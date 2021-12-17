//
//  CreateCountImplementation.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

struct CreateCountImplementation: CreateCountUseCase {
    
    let network: Networkable
    
    init(network: Networkable) {
        self.network = network
    }
    
    func createCount(withTitle title: String, completion: @escaping (Result<[Count], Error>) -> ()) {
        let counts = Counts.create(title: title)
        network.dataRequest(counts.url(), httpMethod: counts.httpMethod, parameters: ["title": title]) { data, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            print("there's data :)")
        }
    }
}
