//
//  GetCountsUseCaseImplementation.swift
//  Counters
//
//  Created by Abner Abbey on 17/12/21.
//

import Foundation

enum MainCountError: Error {
    case noData
    case invalidParse
    case noText
}

struct GetCountsUseCaseImplementation: GetCountUseCase {
    
    let network: Networkable
    let countsEnum: Counts = .all
    
    
    func getCounts(_ completion: @escaping (Result<[Count], Error>) -> ()) {
        
        network.dataRequest(countsEnum.url(), httpMethod: countsEnum.httpMethod, parameters: nil) { data, error in
            
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
