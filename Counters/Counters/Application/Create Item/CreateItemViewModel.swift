//
//  CreateItemViewModel.swift
//  Counters
//
//  Created by Abner Abbey on 13/12/21.
//

import Foundation
import UIKit

protocol CreateItemInterface {
    var title: String? { get }
    var background: UIColor? { get }
    var placeholder: String? { get }
    var leftButtonTitle: String? { get }
    var rightButtonTitle: String? { get }
}

class CreateItemViewModel {
    
    struct UIConfig: CreateItemInterface {
        var title: String?
        var background: UIColor?
        var placeholder: String?
        var leftButtonTitle: String?
        var rightButtonTitle: String?
    }
    
    let uiConfig: CreateItemInterface
    private let createItemUseCase: CreateCountUseCase
    
    var state: Observable<FetchState> = Observable(nil)
    var counterCreated: Observable<Count> = Observable(nil)
    
    init(uiConfig: CreateItemInterface, createItemUseCase: CreateCountUseCase) {
        self.uiConfig = uiConfig
        self.createItemUseCase = createItemUseCase
    }
    
    func createCount(withTitle title: String?) {
        state.onNext(.fetching)
        createItemUseCase.createCount(withTitle: title) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let count):
                    self?.counterCreated.onNext(count)
                    self?.state.onNext(.success)
                case.failure(let error):
                    self?.state.onNext(.failure(error))
                }
            }
        }
    }
    
}
