//
//  MainCoordinator.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    private struct Constants {
        static let hasStartedBefore = "hasStarted"
    }
    
    var rootViewController: UIViewController
    var childCoordinators: [Coordinator] = []
    
    let window: UIWindow
    
    private let dependencyContainer: DependencyContainer
    private let storageInitRepository: StorageInitRepository
    
    init(window: UIWindow, dependecyContaier: DependencyContainer) {
        self.window = window
        self.dependencyContainer = dependecyContaier
        self.storageInitRepository = dependecyContaier.makeStorageRepository()
        rootViewController = UIViewController()
    }
    
    func start() {
        window.rootViewController = rootViewController
        storageInitRepository.read(withKey: Constants.hasStartedBefore) { started in
            DispatchQueue.main.async {
                if started.hasStarted {
                    self.presentMainCounterVC()
                } else {
                    self.presentWelcomeVC()
                    self.storageInitRepository.write(.init(hasStarted: true), withKey: Constants.hasStartedBefore)
                }
            }
        }
        window.makeKeyAndVisible()
    }
    
    private func presentMainCounterVC() {
        let mainCounterVC = MainCounterViewController(factory: dependencyContainer)
        mainCounterVC.delegate = self
        let navigationController = UINavigationController(rootViewController: mainCounterVC)
        rootViewController.addFullScreen(childViewController: navigationController)
    }
    
    private func presentWelcomeVC () {
        let welcomePresenter = WelcomeViewPresenter()
        let welcomeVC = WelcomeViewController(presenter: welcomePresenter)
        welcomeVC.delegate = self
        rootViewController.addFullScreen(childViewController: welcomeVC)
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

//MARK: - WelcomeCounterVC Navigation
extension MainCoordinator: WelcomeViewControllerDelegate {
    func didPressContinueButton() {
        guard let welcomeVC = rootViewController.children.first as? WelcomeViewController else { return }
        rootViewController.remove(childViewController: welcomeVC)
        presentMainCounterVC()
    }
}
