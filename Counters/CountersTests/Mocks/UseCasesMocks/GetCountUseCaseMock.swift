//
//  GetCountUseCaseMock.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation
@testable import Counters


class GetCountUseCaseMock: GetCountUseCase {
    
    private var completion: ((Result<[Count], Error>) -> ())?
    
    func getCounts(_ completion: @escaping (Result<[Count], Error>) -> ()) {
        self.completion = completion
    }
    
    func completionWithSuccess() {
        completion?(.success(CountersStub.getCounts()))
    }
    
    func completionWithFailure() {
        completion?(.failure(MockError.anError))
    }
}
