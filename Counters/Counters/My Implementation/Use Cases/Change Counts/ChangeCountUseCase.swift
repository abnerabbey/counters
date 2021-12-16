//
//  ChangeCountUseCase.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

protocol ChangeCountUseCase {
    func incrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ())
    func decrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ())
}
