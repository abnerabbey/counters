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

protocol StorageInitRepository {
    func read(withKey key: String, handler: @escaping (Any?) -> ())
    func write(_ object: Any, withKey key: String)
}
