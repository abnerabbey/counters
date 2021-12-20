//
//  ChangeUseCaseImplementation.swift
//  Counters
//
//  Created by Abner Abbey on 19/12/21.
//

import Foundation

struct ChangeUseCaseImplementation: ChangeCountUseCase {
    
    let increment: Counts = .increment
    let decrement: Counts = .decrement
    
    let network: Networkable
    
    func incrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ()) {
        network.dataRequest(increment.url(), httpMethod: increment.httpMethod, parameters: ["id": id]) { data, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(CreateItemError.noData))
                return
            }
            
            if let counts = try? JSONDecoder().decode([Count].self, from: data) {
                completion(.success(counts.reversed()))
                return
            } else {
                completion(.failure(CreateItemError.invalidParse))
            }
            
        }.resume()
    }
    
    func decrementCount(withID id: String, completion: @escaping (Result<[Count], Error>) -> ()) {
        network.dataRequest(decrement.url(), httpMethod: decrement.httpMethod, parameters: ["id": id]) { data, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(CreateItemError.noData))
                return
            }
            
            if var counts = try? JSONDecoder().decode([Count].self, from: data) {
                completion(.success(counts.reversed()))
                return
            } else {
                completion(.failure(CreateItemError.invalidParse))
            }
            
        }.resume()
    }
    
    
    
}
