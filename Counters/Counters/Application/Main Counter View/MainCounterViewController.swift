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

class MainCounterViewController: UIViewController {
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
    }
    
    private lazy var toolbar: UIToolbar = create {
        $0.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToCreateItem))], animated: false)
    }
    
    let viewModel: MainCounterViewModel
    private let mainView = MainResponseView()
    
    weak var delegate: MainCounterViewNavigation?
    
    init(factory: MainCounterViewFactory) {
        self.viewModel = factory.makeMainCounterViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = viewModel.uiConfig.title
        view.backgroundColor = viewModel.uiConfig.background
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel.uiConfig.leftButtonTitle, style: .plain, target: self, action: nil)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(toolbar)
        toolbar.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        view.showViewFullScreen(mainView, bottomView: toolbar)
        
        
        mainView.configue(withViewModel: .init(title: "Title", description: "Description", buttonTitle: "Hola :)", action: { button in
        }))
    }
    
}

// MARK: - Objc functions
extension MainCounterViewController {
    
    @objc private func navigateToCreateItem() {
        delegate?.navigate()
    }
    
}
