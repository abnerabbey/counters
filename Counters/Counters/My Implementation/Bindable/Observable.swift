//
//  Observable.swift
//  Counters
//
//  Created by Abner Abbey on 15/12/21.
//

import Foundation


struct Observable<T>: Bindable {
    typealias Observable = T
    
    private var _value: T?
    var value: T? {
        get { _value }
        set {
            _value = newValue
            listener?(newValue)
        }
    }
    
    var listener: ((T?) -> ())?
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    mutating func onNext(_ value: T?) {
        self.value = value
    }
    
    mutating func changingBind(_ value: T?) {
        self._value = value
    }
    
    mutating func bind(_ listener: @escaping (T?) -> ()) {
        self.listener = listener
    }
    
}
