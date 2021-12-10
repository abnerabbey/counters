//
//  CoordinatorTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 10/12/21.
//

import XCTest
@testable import Counters

class MainCoordinatorTests: XCTestCase {

    var sut: MainCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = MainCoordinator(window: .init())
    }
    
    func test_mainCoordinator_canInit() {
        XCTAssertNotNil(sut)
    }
    
    func test_initialState_childCoordinator() {
        XCTAssertEqual(sut.childCoordinators.count, 0)
    }
    
    func test_initialState_navigationController() {
        XCTAssertNotNil(sut.rootViewController)
    }
    
    func test_windowRootVC_whenStarting() {
        sut.start()
        XCTAssertNotNil(sut.window.rootViewController)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

}
