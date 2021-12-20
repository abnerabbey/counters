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
    private let changeCountUseCase: ChangeCountUseCase
    
    private var counts: [Count] = []
    private var filtered: [Count] = []
    
    var createdNewCounter: Observable<Bool> = Observable(false)
    var fetchState: Observable<FetchState> = Observable(nil)
    var error: Observable<String> = Observable(nil)
    var updatedCounter: Observable<Bool> = Observable(false)
    
    init(uiConfig: MainCounterViewModelInterface, getCountsUseCase: GetCountUseCase, changeCountUseCase: ChangeCountUseCase) {
        self.uiConfig = uiConfig
        self.getCountsUseCase = getCountsUseCase
        self.changeCountUseCase = changeCountUseCase
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
    
    func performCounterOperation(withType type: ChangeActionType?, indexPath: IndexPath) {
        guard let type = type else { fatalError("invalid change type") }
        let count = counts[indexPath.row]
        guard let counting = count.count, let id = count.id else { return }
        switch type {
        case .increment:
            changeCountUseCase.incrementCount(withID: id) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let counts):
                        self?.counts = counts
                        self?.updatedCounter.onNext(true)
                    case .failure(_):
                        self?.error.onNext("Couldn't update the \(count.title ?? "") to \(counting + 1)")
                    }
                }
            }
        case .decrement:
            guard counting > 0 else { return }
            changeCountUseCase.decrementCount(withID: id) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let counts):
                        self?.counts = counts
                        self?.updatedCounter.onNext(true)
                    case .failure(_):
                        self?.error.onNext("Couldn't update the \(count.title ?? "") to \(counting + 1)")
                    }
                }
            }
        }
    }
    
    func search(withText text: String) {
        filtered = counts
        filtered = filtered.filter { $0.title!.replacingOccurrences(of: " ", with: "").lowercased().contains(text.replacingOccurrences(of: " ", with: "").lowercased()) }
        
    }
}

protocol CountersViewModelInterface {
    var count: Int { get }
    subscript(index: Int) -> CounterViewModel { get }
}

extension MainCounterViewModel: CountersViewModelInterface {
    var count: Int { counts.count }
    subscript(index: Int) -> CounterViewModel {
        CounterViewModel(model: counts[index])
    }
}


