//
//  InitialFactories.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

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
