//
//  NetworkMock.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation
@testable import Counters

class SessionTask: URLSessionDataTask {
    
    
    
}

class NetworkMock: Networkable {
    
    func jsonRequest(_ url: URL, httpMethod method: String, parameters: [String : String]?, completionHandler completion: @escaping JSONCompletionHandler) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url)
    }
    
    func dataRequest(_ url: URL, httpMethod method: String, parameters: [String : String]?, completionHandler completion: @escaping DataCompletionHandler) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url)
    }
    
    
    
    
}
