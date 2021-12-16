//
//  GetCountsUseCases.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

protocol GetCountUseCase {
    func getCounts(_ completion: @escaping (Result<[Count], Error>) -> ())
}
