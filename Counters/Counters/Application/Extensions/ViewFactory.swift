//
//  ViewFactory.swift
//  Counters
//
//  Created by Abner Abbey on 12/12/21.
//

import Foundation
import UIKit

extension UILabel {
    
    struct Configuration {
        let font: UIFont
        let textColor: UIColor
    }
    
    static func withConfig(_ config: UILabel.Configuration) -> UILabel {
        let label = UILabel()
        label.font = config.font
        label.textColor = config.textColor
        return label
    }
}
