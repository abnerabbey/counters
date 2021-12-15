//
//  StorageRepository.swift
//  Counters
//
//  Created by Abner Abbey on 14/12/21.
//

import Foundation

enum StorageError: Error {
    case invalidKey
    case notExistingData
}

public struct FirstInit: Codable {
    var hasStarted: Bool = false
}

protocol StorageInitRepository {
    associatedtype Object
    func read(withKey key: String, handler: @escaping (Object) -> ())
    func write(_ object: Object, withKey key: String)
}

struct AnyStorageInitRepository<T>: StorageInitRepository {
    
    private let _read: (_: String, _: @escaping (T) -> ()) -> ()
    private let _write: (_: T, _: String) -> ()
    
    init<U: StorageInitRepository>(repository: U) where U.Object == T {
        _read = repository.read
        _write = repository.write
    }
    
    func read(withKey key: String, handler: @escaping (T) -> ()) {
        _read(key, handler)
    }
    
    func write(_ object: T, withKey key: String) {
        _write(object, key)
    }
    
    
}
