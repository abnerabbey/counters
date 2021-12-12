//
//  DependencyStub.swift
//  CountersTests
//
//  Created by Abner Abbey on 12/12/21.
//

import Foundation
import UIKit
@testable import Counters

class DependencyStub: MainCounterViewFactory {
    
    func makeMainCounterViewModel() -> MainCounterViewModel {
        let uiconfig = MainCounterViewModel.UIConfig(title: "Counters", background: UIColor(named: "Background")!)
        return MainCounterViewModel(uiConfig: uiconfig)
    }
    
}
