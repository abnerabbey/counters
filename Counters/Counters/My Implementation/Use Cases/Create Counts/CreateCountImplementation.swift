//
//  CreateCountImplementation.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

enum CreateItemError: Error {
    case noData
    case invalidParse
    case noText
}

struct CreateCountImplementation: CreateCountUseCase {
    
    let network: Networkable
    let countsEnum: Counts = .create
    
    init(network: Networkable) {
        self.network = network
    }
    
    func createCount(withTitle title: String?, completion: @escaping (Result<Count, Error>) -> ()) {
        guard let title = title, title.count > 0 else {
            completion(.failure(CreateItemError.noText))
            return
        }
        network.dataRequest(countsEnum.url(), httpMethod: countsEnum.httpMethod, parameters: ["title": title]) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(CreateItemError.noData))
                return
            }
            
            if let counts = try? JSONDecoder().decode([Count].self, from: data), let count = counts.last {
                completion(.success(count))
                return
            } else {
                completion(.failure(CreateItemError.invalidParse))
            }
        }.resume()
    }
}
