//
//  ChangeCountUseCase.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

enum ChangeCountError: Error {
    case notAble(String)
}

public enum ChangeActionType: Int {
    case decrement = 1
    case increment
}

protocol ChangeCountUseCase {
    func incrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ())
    func decrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ())
}


