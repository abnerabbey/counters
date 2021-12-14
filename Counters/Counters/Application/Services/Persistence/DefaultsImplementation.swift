//
//  DefaultsImplementation.swift
//  Counters
//
//  Created by Abner Abbey on 14/12/21.
//

import Foundation

struct DefaultsImplementation: StorageInitRepository {
    
    let defaults = UserDefaults.standard
    let queue = DispatchQueue(label: "com.Counters.storageQueue")
    
    func read(withKey key: String, handler: @escaping (Any?) -> ()) {
        queue.async {
            guard let value = defaults.object(forKey: key) as? Bool else {
                handler(false)
                return
            }
            
            if value {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    func write(_ object: Any, withKey key: String) {
        defaults.setValue(object, forKey: key)
    }
}
