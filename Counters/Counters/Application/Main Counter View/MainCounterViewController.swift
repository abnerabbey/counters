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
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var tableView: UITableView = create {
        $0.backgroundColor = viewModel.uiConfig.background
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }
    
    private lazy var toolbar: UIToolbar = create {
        $0.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToCreateItem))], animated: false)
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    let viewModel: MainCounterViewModel
    private let mainView = MainResponseView()
    
    weak var delegate: MainCounterViewNavigation?
    var tableDataSource: FeedTableDataSource<UITableViewCell>?
    
    init(factory: MainCounterViewFactory) {
        self.viewModel = factory.makeMainCounterViewModel()
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
        tableView.register(CountCell.self, forCellReuseIdentifier: "countCell")
        tableDataSource = FeedTableDataSource(cellIdentifier: "countCell", items: viewModel.count, configureCell: { [weak self] cell, indexPath in
            guard let self = self, let cell = cell as? CountCell else { return }
            cell.configure(withModel: self.viewModel[indexPath.row])
        })
        tableView.separatorColor = .clear
        tableView.dataSource = tableDataSource
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.uiConfig.leftButtonTitle, style: .plain, target: self, action: nil)
        
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
    
}

// MARK: - Binding objects
extension MainCounterViewController {
    
    private func binds() {
        bindFetchState()
        bindCounterCreation()
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
        else { activityIndicator.stopAnimating() }
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
