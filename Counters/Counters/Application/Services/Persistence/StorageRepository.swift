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
    func read(withKey key: String, handler: @escaping (FirstInit) -> ())
    func write(_ object: FirstInit, withKey key: String)
}
