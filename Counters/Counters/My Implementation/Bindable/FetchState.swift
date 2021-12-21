//
//  FetchState.swift
//  Counters
//
//  Created by Abner Abbey on 17/12/21.
//

import Foundation

enum FetchState: Equatable {
    case fetching
    case success
    case failure(Error)
}

extension FetchState {
    static func == (lhs: FetchState, rhs: FetchState) -> Bool {
        switch (lhs, rhs) {
        case let (.failure(a), .failure(b)):
            return protocol_isEqual(a as? Protocol, b as? Protocol)
        default:
            return true
        }
    }
}
