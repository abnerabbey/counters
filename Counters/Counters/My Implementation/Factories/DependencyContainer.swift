//
//  DependencyContainer.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

class DependencyContainer {
    
    let mainCoordinator: Coordinator
    
    init(window: UIWindow) {
        func makeMainCoordinator() -> Coordinator {
            return MainCoordinator(window: window)
        }
        
        self.mainCoordinator = makeMainCoordinator()
        self.mainCoordinator.start()
    }
}
