//
//  CreateItemViewModel.swift
//  Counters
//
//  Created by Abner Abbey on 13/12/21.
//

import Foundation
import UIKit

protocol CreateItemInterface {
    var title: String? { get }
    var background: UIColor? { get }
    var placeholder: String? { get }
    var leftButtonTitle: String? { get }
    var rightButtonTitle: String? { get }
}

struct CreateItemViewModel {
    
    struct UIConfig: CreateItemInterface {
        var title: String?
        var background: UIColor?
        var placeholder: String?
        var leftButtonTitle: String?
        var rightButtonTitle: String?
    }
    
    let uiConfig: CreateItemInterface
    
}
