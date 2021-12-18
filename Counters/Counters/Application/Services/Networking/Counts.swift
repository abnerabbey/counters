//
//  Counts.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

enum Counts {
    case create
    case all
}

extension Counts {
    static let baseURL = "http://127.0.0.1:3000"
    
    var httpMethod: String {
        switch self {
        case .all: return "GET"
        case .create: return "POST"
        }
    }
    
    var endpoint: String {
        let baseURL = "http://127.0.0.1:3000"
        switch self {
        case .create:
            return "\(baseURL)/api/v1/counter"
        case .all:
            return "\(baseURL)/api/v1/counters"
        }
        
    }
    
    func url() -> URL {
        guard let url = URL(string: endpoint) else { fatalError("Invalid URL on Counts endpoint") }
        return url
    }
}
