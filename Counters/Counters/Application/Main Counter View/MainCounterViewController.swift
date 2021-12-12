//
//  MainCounterViewController.swift
//  Counters
//
//  Created by Abner Abbey on 12/12/21.
//

import UIKit

class MainCounterViewController: UIViewController {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var tableView: UITableView = create {
        $0.backgroundColor = UIColor(named: "Background")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let viewModel: MainCounterViewModel
    let mainView = MainResponseView()
    
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
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
        view.addSubview(mainView)
        mainView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
    }
    
}
