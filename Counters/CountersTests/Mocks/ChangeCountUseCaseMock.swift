//
//  ChangeCountUseCaseMock.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation
@testable import Counters

class ChangeCountUseCaseMock: ChangeCountUseCase {
    func incrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ()) {
        
    }
    
    func decrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ()) {
        
    }
    
    
}
