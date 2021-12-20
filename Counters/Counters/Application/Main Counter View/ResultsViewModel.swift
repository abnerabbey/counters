//
//  ResultsViewModel.swift
//  Counters
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation

struct ResultsViewModel: CountersViewModelInterface {
    
    var filtered: [Count] = []
    
    var resultsHiddien: Observable<Bool> = Observable(true)
    
    var count: Int { filtered.count }
    
    subscript(index: Int) -> CounterViewModel {
        CounterViewModel(model: filtered[index])
    }
    
    
}
