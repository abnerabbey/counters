//
//  MainCounterViewModel.swift
//  Counters
//
//  Created by Abner Abbey on 12/12/21.
//

import Foundation
import UIKit

protocol MainCounterViewModelInterface {
    var title: String? { get }
    var background: UIColor? { get }
    var leftButtonTitle: String? { get }
}

struct MainCounterViewModel {
    
    struct UIConfig:  MainCounterViewModelInterface {
        var title: String?
        var background: UIColor?
        var leftButtonTitle: String?
    }
    
    let uiConfig: MainCounterViewModelInterface
    
    
    
}


