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
    
    fileprivate var navigationController: UINavigationViewControllerStub!
    
    override func setUp() {
        super.setUp()
        dependencyStub = DependencyStub()
        sut = MainCounterViewController(factory: dependencyStub)
        navigationController = UINavigationViewControllerStub(rootViewController: sut)
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
    
    func test_viewControllerTitleIsCounters() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Counters")
    }
    
    
    
    override func tearDown() {
        super.tearDown()
        dependencyStub = nil
        sut = nil
    }
}

private class UINavigationViewControllerStub: UINavigationController {
    
}
