//
//  MainCounterViewModel.swift
//  Counters
//
//  Created by Abner Abbey on 12/12/21.
//

import Foundation
import UIKit

enum ViewModelError: Error {
    case empty
}

protocol MainCounterViewModelInterface {
    var title: String? { get }
    var background: UIColor? { get }
    var leftButtonTitle: String? { get }
}

class MainCounterViewModel {
    
    struct UIConfig:  MainCounterViewModelInterface {
        var title: String?
        var background: UIColor?
        var leftButtonTitle: String?
    }
    
    let uiConfig: MainCounterViewModelInterface
    private let getCountsUseCase: GetCountUseCase
    
    private var counts: [Count] = []
    
    var createdNewCounter: Observable<Bool> = Observable(false)
    var fetchState: Observable<FetchState> = Observable(nil)
    
    init(uiConfig: MainCounterViewModelInterface, getCountsUseCase: GetCountUseCase) {
        self.uiConfig = uiConfig
        self.getCountsUseCase = getCountsUseCase
    }
    
    func getCounters() {
        fetchState.onNext(.fetching)
        getCountsUseCase.getCounts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let counters):
                    self?.counts = counters
                    if counters.count == 0 {
                        self?.fetchState.onNext(.failure(ViewModelError.empty))
                    } else {
                        self?.fetchState.onNext(.success)
                    }
                case .failure(let error):
                    self?.fetchState.onNext(.failure(error))
                }
            }
        }
    }
    
    func didAddNewCounter(_ counter: Count) {
        counts.insert(counter, at: 0)
        createdNewCounter.onNext(true)
    }
    
    
}

protocol CountersViewModelInterface {
    var count: Int { get }
    subscript(index: Int) -> Count { get }
}

extension MainCounterViewModel: CountersViewModelInterface {
    var count: Int { counts.count }
    subscript(index: Int) -> Count {
        counts[index]
    }
}


