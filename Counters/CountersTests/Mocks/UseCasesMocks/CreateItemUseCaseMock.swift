//
//  CreateItemUseCaseMock.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation
@testable import Counters

enum MockError: Error {
    case anError
}

class CreateItemUseCaseMock: CreateCountUseCase {
    
    let network: Networkable
    
    private let count = CountersStub.getCount()
    
    var completion: ((Result<Count, Error>) -> ())?
    
    init(network: Networkable) {
        self.network = network
    }
    
    func createCount(withTitle title: String?, completion: @escaping (Result<Count, Error>) -> ()) {
        self.completion = completion
    }
    
    func completionWithSuccess() {
        completion?(.success(count))
    }
    
    func completionWithError() {
        completion?(.failure(MockError.anError))
    }
    
}
