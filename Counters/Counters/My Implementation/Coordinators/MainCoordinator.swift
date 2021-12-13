//
//  MainCoordinator.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    var childCoordinators: [Coordinator] = []
    
    let window: UIWindow
    
    private let dependencyContainer: DependencyContainer
    
    init(window: UIWindow, dependecyContaier: DependencyContainer) {
        self.window = window
        self.dependencyContainer = dependecyContaier
        rootViewController = UIViewController()
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let mainCounterVC = MainCounterViewController(factory: dependencyContainer)
        mainCounterVC.delegate = self
        let navigationController = UINavigationController(rootViewController: mainCounterVC)
        rootViewController.addFullScreen(childViewController: navigationController)
    }
    
}

//MARK: - MainCounterVC Navigation
extension MainCoordinator: MainCounterViewNavigation {
    func navigate() {
        let createItemVC = CreateItemViewController()
        createItemVC.viewModel = CreateItemViewModel(uiConfig: CreateItemViewModel.UIConfig(title: "Create Count", background: UIColor(named: "Background")!, placeholder: "Type your count...", leftButtonTitle: "Cancel", rightButtonTitle: "Save"))
        let nv = UINavigationController(rootViewController: createItemVC)
        rootViewController.present(nv, animated: true, completion: nil)
    }
}
