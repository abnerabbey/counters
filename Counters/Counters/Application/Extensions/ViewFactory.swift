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

extension UIButton {
    
    struct Config {
        let title: String
        let font: UIFont
        let textColor: UIColor
    }
    
    static func withConfig(_ config: UIButton.Config) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(config.title, for: .normal)
        button.titleLabel?.font = config.font
        button.tintColor = config.textColor
        return button
    }
}
