//
//  DependencyContainer.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

class DependencyContainer: StorageRepositoryFactory {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func makeMainCoordinator() -> MainCoordinator {
        return MainCoordinator(window: window, dependecyContaier: self)
    }
    
    func makeStorageRepository() -> AnyStorageInitRepository<FirstInit> {
        return AnyStorageInitRepository(repository: DefaultsImplementation())
    }
}

extension DependencyContainer: WelcomeViewFactory {
    func makeWelcomeViewController() -> WelcomeViewController {
        let presenter = WelcomeViewPresenter()
        return WelcomeViewController(presenter: presenter)
    }
}

extension DependencyContainer: MainCounterViewFactory {
    func makeMainCounterViewModel() -> MainCounterViewModel {
        let uiConfig = MainCounterViewModel.UIConfig(title: "Counters", background: UIColor(named: "Background")!, leftButtonTitle: "Edit")
        return MainCounterViewModel(uiConfig: uiConfig)
    }
}
