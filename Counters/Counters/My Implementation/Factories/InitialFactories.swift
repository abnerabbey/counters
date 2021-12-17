//
//  InitialFactories.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

// MARK: - Welcome an Main Composition
protocol WelcomeViewFactory {
    func makeWelcomeViewController() -> WelcomeViewController
}

protocol MainCounterViewFactory {
    //func makeMainCounterViewController() -> MainCounterViewController
    func makeMainCounterViewModel() -> MainCounterViewModel
}

protocol StorageRepositoryFactory {
    
    func makeStorageRepository() -> AnyStorageInitRepository<FirstInit>
}

// MARK: - Networking Composition
protocol NetworkingFactory {
    func makeNetworkLayer() -> Networkable
}

// MARK: - Create Count Composition
protocol CreateItemViewControllerFactory {
    func makeCreateItemViewController() -> UIViewController
}

protocol CreateItemViewModelFactory {
    func makeCreateItemViewController() -> UIViewController
    func makeCreateItemUseCase() -> CreateCountUseCase
    func makeCreateItemViewModel() -> CreateItemViewModel
}
