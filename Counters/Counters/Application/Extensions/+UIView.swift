//
//  +View.swift
//  Counters
//
//  Created by Abner Abbey on 12/12/21.
//

import Foundation
import UIKit

public func create<T: NSObject>(_ setup: (T) -> ()) -> T {
    let obj = T()
    setup(obj)
    return obj
}


// MARK: - Subviews stuff
extension UIView {
    
    func showViewFullScreen(_ view: UIView, bottomView: UIView? = nil) {
        addSubview(view)
        view.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomView?.topAnchor ?? bottomAnchor)
    }
    
    func removeSubview(_ view: UIView) {
        view.removeFromSuperview()
    }
    
}

// MARK: - Auto alyout stuff
extension UIView {
    
    func dimensionAnchors(height: NSLayoutDimension?, heightMultiplier: CGFloat = 1.0, width: NSLayoutDimension?, widthMultiplier: CGFloat = 1.0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier).isActive = true
        }
    }
    
    func centerAnchors(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func sizeAnchors(size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if size.width > 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height > 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, multiplier: CGFloat = 0.0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}
