//
//  CounterViewModel.swift
//  Counters
//
//  Created by Abner Abbey on 19/12/21.
//

import Foundation
import UIKit

struct CounterViewModel {
    
    private let model: Count
    
    var title: String { model.title ?? "" }
    var count: String { "\(model.count ?? 0)" }
    var color: UIColor {
        if model.count == 0 {
            return UIColor(named: "DisabledText")!
        } else {
            return UIColor(named: "AccentColor")!
        }
    }
    
    init(model: Count) {
        self.model = model
    }
    
}
