//
//  CreateItemViewControllerTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 13/12/21.
//

import XCTest
@testable import Counters

class CreateItemViewControllerTests: XCTestCase {
    
    var sut: CreateItemViewController!
    
    override func setUp() {
        super.setUp()
        sut = CreateItemViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

}
