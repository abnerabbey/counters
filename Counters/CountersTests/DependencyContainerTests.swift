//
//  DependencyContainerTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 10/12/21.
//

import XCTest
@testable import Counters

class DependencyContainerTests: XCTestCase {
    
    var sut: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        sut = DependencyContainer(window: .init())
    }

    func test_containerInit() {
        XCTAssertNotNil(sut)
    }
    
    func test_containerCanMakeMainCoordinator() {
        XCTAssertNotNil(sut.makeMainCoordinator())
    }
    
    func test_containerCanMakeWelcomeViewController() {
        XCTAssertNotNil(sut.makeWelcomeViewController)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

}
