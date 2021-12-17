//
//  CreateCountUseCase.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

protocol CreateCountUseCase {
    func createCount(withTitle title: String?, completion: @escaping (Result<[Count], Error>) -> ())
}
