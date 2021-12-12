//
//  Coordinator.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
