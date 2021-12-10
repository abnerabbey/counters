//
//  InitialFactories.swift
//  Counters
//
//  Created by Abner Abbey on 10/12/21.
//

import Foundation
import UIKit

protocol MainViewControllerFactory {
    func makeMainViewController() -> UINavigationController
}
