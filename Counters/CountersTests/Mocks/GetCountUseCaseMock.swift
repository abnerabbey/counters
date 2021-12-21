//
//  GetCountUseCaseMock.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation
@testable import Counters


class GetCountUseCaseMock: GetCountUseCase {
    func getCounts(_ completion: @escaping (Result<[Count], Error>) -> ()) {
        
    }
}
