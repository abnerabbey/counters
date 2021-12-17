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

// MARK: - Welcome and Main Factories
extension DependencyContainer: WelcomeViewFactory {
    func makeWelcomeViewController() -> WelcomeViewController {
        let presenter = WelcomeViewPresenter()
        return WelcomeViewController(presenter: presenter)
    }
}

extension DependencyContainer: MainCounterViewFactory {
    func makeMainCounterViewModel() -> MainCounterViewModel {
        let uiConfig = MainCounterViewModel.UIConfig(title: Localizables.MainView.title.localized, background: UIColor(named: "Background")!, leftButtonTitle: Localizables.MainView.main_edit_button.localized)
        return MainCounterViewModel(uiConfig: uiConfig)
    }
}

// MARK: - Networkable Factories
extension DependencyContainer: NetworkingFactory {
    func makeNetworkLayer() -> Networkable {
        return Networking()
    }
}

// MARK: - Create Count Composition Factories
extension DependencyContainer: CreateItemViewModelFactory {
    func makeCreateItemViewController() -> UIViewController {
        let vc = CreateItemViewController()
        vc.viewModel = makeCreateItemViewModel()
        return vc
    }
    
    func makeCreateItemUseCase() -> CreateCountUseCase {
        return CreateCountImplementation(network: makeNetworkLayer())
    }
    
    func makeCreateItemViewModel() -> CreateItemViewModel {
        return CreateItemViewModel(uiConfig: CreateItemViewModel.UIConfig(title: Localizables.CreateItemView.title.localized, background: UIColor(named: "Background")!, placeholder: Localizables.CreateItemView.placeholder.localized, leftButtonTitle: Localizables.CreateItemView.leftButton.localized, rightButtonTitle: Localizables.CreateItemView.rightButton.localized), createItemUseCase: makeCreateItemUseCase())
    }
    
    
}
