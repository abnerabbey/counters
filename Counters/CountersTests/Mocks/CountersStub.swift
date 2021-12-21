//
//  CountersStub.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import Foundation
@testable import Counters

class CountersStub {
    
    class func getCount() -> Count {
        return Count(id: "H77283d", title: "I'm a new counter", count: 0)
    }
    
    class func getCountWithCount() -> Count {
        return Count(id: "H77283d", title: "I'm a new counter", count: 10)
    }
    
    class func getCounts() -> [Count] {
        return [Count(id: "72387y", title: "One", count: 0),
                Count(id: "7823h", title: "Two", count: 0),
                Count(id: "8u923", title: "Three", count: 0),
                Count(id: "8j98", title: "Four", count: 0),
                Count(id: "u84", title: "Five", count: 0)]
    }
    
    class func getConfiguration() -> CreateItemInterface {
        return CreateItemViewModel.UIConfig(title: "Counters", background: .orange, placeholder: "Test", leftButtonTitle: "left", rightButtonTitle: "right")
    }
    
    class func getMainConfiguration() -> MainCounterViewModelInterface {
        return MainCounterViewModel.UIConfig(title: "Counters", background: .orange, leftButtonTitle: "left")
    }
    
}
