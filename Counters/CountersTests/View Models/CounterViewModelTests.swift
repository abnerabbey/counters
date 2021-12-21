//
//  CounterViewModelTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import XCTest
@testable import Counters

class CounterViewModelTests: XCTestCase {
    
    var sut: CounterViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CounterViewModel(model: CountersStub.getCount())
    }
    
    func test_titleIsCount() {
        let model = CountersStub.getCount()
        XCTAssertTrue(sut.title == model.title)
    }
    
    func test_countIsEqualToCount() {
        let model = CountersStub.getCount()
        XCTAssertTrue(sut.count == "\(model.count ?? 0)")
    }
    
    func test_colorIsGrey_whenNoCount() {
        let color = UIColor(named: "DisabledText")
        XCTAssertEqual(color, sut.color)
    }
    
    func test_colorIsAccentColor_whenCount() {
        let color = UIColor(named: "AccentColor")
        sut = CounterViewModel(model: CountersStub.getCountWithCount())
        XCTAssertEqual(color, sut.color)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

}
