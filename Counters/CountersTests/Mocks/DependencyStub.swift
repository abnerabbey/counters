//
//  DependencyStub.swift
//  CountersTests
//
//  Created by Abner Abbey on 12/12/21.
//

import Foundation
import UIKit
@testable import Counters

class DependencyStub: MainCounterViewFactory, CreateItemViewModelFactory {
    func makeCreateItemUseCase() -> CreateCountUseCase {
        CreateItemUseCaseMock(network: NetworkMock())
    }
    
    func makeCreateItemViewModel() -> CreateItemViewModel {
        CreateItemViewModel(uiConfig: CountersStub.getConfiguration(), createItemUseCase: makeCreateItemUseCase())
    }
    
    func makeGetCountersUseCase() -> GetCountUseCase {
        return GetCountUseCaseMock()
    }
    
    func makeResultsViewController() -> UIViewController {
        return UIViewController()
    }
    
    
    func makeMainCounterViewModel() -> MainCounterViewModel {
        let uiconfig = MainCounterViewModel.UIConfig(title: "Counters", background: UIColor(named: "Background")!)
        return MainCounterViewModel(uiConfig: MainCounterViewModel.UIConfig(title: "Counters", background: .orange, leftButtonTitle: "left"), getCountsUseCase: makeGetCountersUseCase(), changeCountUseCase: ChangeCountUseCaseMock())
    }
    
}
