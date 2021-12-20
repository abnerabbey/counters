//
//  Count.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

struct CountResult: Decodable {
    let counts: [Count]
}

struct Count: Decodable {
    let id: String?
    let title: String?
    let count: Int?
}
