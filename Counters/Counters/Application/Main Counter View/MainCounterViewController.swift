//
//  MainCounterViewController.swift
//  Counters
//
//  Created by Abner Abbey on 12/12/21.
//

import UIKit

public protocol MainCounterViewNavigation: AnyObject {
    func navigate()
}

class MainCounterViewController: UIViewController, UITableViewDelegate {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    private lazy var tableView: UITableView = create {
        $0.backgroundColor = viewModel.uiConfig.background
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }
    
    private lazy var toolbar: UIToolbar = create {
        $0.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToCreateItem))], animated: false)
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private struct Constants {
        static let counteCellID = "countCell"
    }
    
    let viewModel: MainCounterViewModel
    private let mainView = MainResponseView()
    
    weak var delegate: MainCounterViewNavigation?
    var tableDataSource: FeedTableDataSource<UITableViewCell>?
    var resultsViewController: UIViewController
    
    init(factory: MainCounterViewFactory) {
        self.viewModel = factory.makeMainCounterViewModel()
        self.resultsViewController = factory.makeResultsViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        binds()
        viewModel.getCounters()
    }
    
    private func setupView() {
        title = viewModel.uiConfig.title
        view.backgroundColor = viewModel.uiConfig.background
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        refreshControl.addTarget(self, action: #selector(retryOperations), for: .valueChanged)
        tableView.register(CountCell.self, forCellReuseIdentifier: Constants.counteCellID)
        tableDataSource = FeedTableDataSource(cellIdentifier: Constants.counteCellID, items: viewModel.count, configureCell: { [weak self] cell, indexPath in
            guard let self = self, let cell = cell as? CountCell else { return }
            cell.configure(withViewModel: self.viewModel[indexPath.row])
            cell.buttonAction = { [weak self, indexPath] changeType in
                self?.viewModel.performCounterOperation(withType: changeType, indexPath: indexPath)
            }
        })
        tableView.separatorColor = .clear
        tableView.refreshControl = refreshControl
        tableView.dataSource = tableDataSource
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.uiConfig.leftButtonTitle, style: .plain, target: self, action: #selector(edit))
        
        view.addSubview(activityIndicator)
        activityIndicator.centerAnchors(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(toolbar)
        toolbar.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

// MARK: - Objc functions
extension MainCounterViewController {
    
    @objc private func navigateToCreateItem() {
        delegate?.navigate()
    }
    
    @objc private func retryOperations() {
        viewModel.getCounters()
    }
    
    // TODO
    @objc private func edit() {
        showAlert(withTitle: "Counters", message: "Coming soon...")
    }
    
}

// MARK: - SearchBar delegate
extension MainCounterViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(withText: searchText)
    }
    
}

// MARK: - Binding objects
extension MainCounterViewController {
    
    private func binds() {
        bindFetchState()
        bindCounterCreation()
        bindUpdateCounter()
        bindError()
        bindFilters()
    }
    
    private func bindFetchState() {
        viewModel.fetchState.bind { [weak self] state in
            guard let self = self, let state = state else { return }
            switch state {
            case .fetching:
                self.isFetching(true)
            case .success:
                self.isFetching(false)
                self.reloadTableView()
            case .failure(let error):
                self.isFetching(false)
                guard let error = error as? ViewModelError else {
                    self.setRetryMainView()
                    return
                }
                switch error {
                case .empty:
                    self.setNoContentView()
                }
            }
        }
    }
    
    private func bindCounterCreation() {
        viewModel.createdNewCounter.bind { [weak self] _ in
            self?.reloadTableView()
            self?.isFetching(false)
        }
    }
    
    private func bindUpdateCounter() {
        viewModel.updatedCounter.bind { [weak self] _ in
            self?.reloadTableView()
        }
    }
    
    private func bindError() {
        viewModel.error.bind { [weak self] error in
            self?.showAlert(withTitle: error, message: Localizables.MainViewActionError.description.localized)
        }
    }
    
    private func bindFilters() {
        viewModel.filtered.bind { [weak self] filtered in
            guard let self = self, let resultsVC = self.searchController.searchResultsController as? ResultsViewController, let filtered = filtered else { return }
            resultsVC.viewModel?.filtered = filtered
            resultsVC.tableView.reloadData()
            resultsVC.viewModel?.resultsHiddien.onNext(filtered.count != 0)
        }
    }
    
    
}

// MARK: - Helper Functions
extension MainCounterViewController {
    
    private func reloadTableView() {
        self.tableDataSource?.items = self.viewModel.count
        self.tableView.reloadData()
    }
    
    private func isFetching(_ fetching: Bool) {
        view.removeSubview(mainView)
        if fetching { activityIndicator.startAnimating() }
        else {
            refreshControl.endRefreshing()
            activityIndicator.stopAnimating()
        }
        tableView.isHidden = fetching
    }
    
    private func setRetryMainView() {
        view.showViewFullScreen(mainView, bottomView: toolbar)
        mainView.configue(withViewModel: .init(title: Localizables.MainViewActionError.title.localized, description: Localizables.MainViewActionError.description.localized, buttonTitle: Localizables.MainViewActionError.buttonTitle.localized, action: { [weak self] _ in
            self?.viewModel.getCounters()
        }))
    }
    
    private func setNoContentView() {
        view.showViewFullScreen(mainView, bottomView: toolbar)
        mainView.configue(withViewModel: .init(title: Localizables.MainViewActionEmpty.title.localized, description: Localizables.MainViewActionEmpty.description.localized, buttonTitle: Localizables.MainViewActionEmpty.buttonTitle.localized, action: { [weak self] _ in
            self?.delegate?.navigate()
        }))
    }
    
}
