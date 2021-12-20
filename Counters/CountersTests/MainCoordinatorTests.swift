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
    var dependencyContainer: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        let window = UIWindow()
        dependencyContainer = DependencyContainer(window: window)
        sut = dependencyContainer.makeMainCoordinator()
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
        dependencyContainer = nil
        sut = nil
    }

}
