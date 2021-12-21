//
//  ResultsViewModelTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import XCTest
@testable import Counters

class ResultsViewModelTests: XCTestCase {

    var sut: ResultsViewModel!
    
    override func setUp() {
        super.setUp()
        sut = ResultsViewModel()
    }
    
    
    func test_countIsFilteredProperty() {
        sut.filtered = CountersStub.getCounts()
        XCTAssertTrue(sut.count > 0)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    
}
