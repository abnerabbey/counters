//
//  DefaultsImplementation.swift
//  Counters
//
//  Created by Abner Abbey on 14/12/21.
//

import Foundation



struct DefaultsImplementation: StorageInitRepository {
    
    typealias Object = FirstInit
    
    let defaults = UserDefaults.standard
    let queue = DispatchQueue(label: "com.Counters.storageQueue")
    
    func read(withKey key: String, handler: @escaping (FirstInit) -> ()) {
        queue.async {
            guard let data = defaults.data(forKey: key), let value = try? JSONDecoder().decode(Object.self, from: data) else {
                handler(FirstInit())
                return
            }
            handler(value)
        }
    }
    
    func write(_ object: FirstInit, withKey key: String) {
        queue.async {
            let data = try? JSONEncoder().encode(object)
            defaults.setValue(data, forKey: key)
        }
    }

}
