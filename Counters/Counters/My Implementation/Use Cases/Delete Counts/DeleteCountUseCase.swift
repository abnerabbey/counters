//
//  DeleteCountUseCase.swift
//  Counters
//
//  Created by Abner Abbey on 16/12/21.
//

import Foundation

protocol DeleteCountUseCase {
    func deleteCount(withID id: String, completion: @escaping(Result<[Count], Error>) -> ())
}
