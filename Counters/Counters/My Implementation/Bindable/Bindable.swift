//
//  Bindable.swift
//  Counters
//
//  Created by Abner Abbey on 15/12/21.
//

import Foundation

protocol Bindable {
    associatedtype Observable
    
    var value: Observable? { get set }
    var listener: ((Observable?) -> ())? { get set }
    
    mutating func  bind(_ listener: @escaping (Observable?) -> ())
    mutating func onNext(_ value: Observable?)
    mutating func changingBind(_ value: Observable?)
}
