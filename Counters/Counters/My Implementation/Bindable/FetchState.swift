//
//  FetchState.swift
//  Counters
//
//  Created by Abner Abbey on 17/12/21.
//

import Foundation

enum FetchState {
    case fetching
    case success
    case failure(Error)
}
