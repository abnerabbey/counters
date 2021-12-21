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
    
    class func getConfiguration() -> CreateItemInterface {
        return CreateItemViewModel.UIConfig(title: "Counters", background: .orange, placeholder: "Test", leftButtonTitle: "left", rightButtonTitle: "right")
    }
    
}
