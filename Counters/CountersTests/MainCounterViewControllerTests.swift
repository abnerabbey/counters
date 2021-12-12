//
//  MainCounterViewControllerTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 12/12/21.
//

import XCTest
@testable import Counters

class MainCounterViewControllerTests: XCTestCase {
    var sut: MainCounterViewController!
    var dependencyStub: DependencyStub!
    
    override func setUp() {
        super.setUp()
        dependencyStub = DependencyStub()
        sut = MainCounterViewController(factory: dependencyStub)
    }
    
    func test_sutCanInit() {
        XCTAssertNotNil(sut)
    }
    
    func test_viewModelExists() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func test_viewModelHasConfiguration() {
        XCTAssertEqual(sut.viewModel.uiConfig.title, "Counters")
    }
    
    
    
    override func tearDown() {
        super.tearDown()
        dependencyStub = nil
        sut = nil
    }
}

