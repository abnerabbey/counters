//
//  ChangeCountUseCaseMock.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation
@testable import Counters

class ChangeCountUseCaseMock: ChangeCountUseCase {
    
    var completion: ((Result<[Count], Error>) -> ())?
    
    func incrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ()) {
        self.completion = completion
    }
    
    func decrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ()) {
        self.completion = completion
    }
    
    
    func completionWithSucces() {
        completion?(.success(CountersStub.getCounts()))
    }
    
    func completionWithError() {
        completion?(.failure(MockError.anError))
    }
    
    
}
