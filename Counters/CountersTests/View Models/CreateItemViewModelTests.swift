//
//  CreateItemViewModelTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 13/12/21.
//

import XCTest
@testable import Counters

class CreateItemViewModelTests: XCTestCase {
    
    var sut: CreateItemViewModel!
    var dependencyStub: DependencyStub!
    var createItemUseCase: CreateItemUseCaseMock!
    
    override func setUp() {
        super.setUp()
        dependencyStub = DependencyStub()
        createItemUseCase = dependencyStub.makeCreateItemUseCase() as! CreateItemUseCaseMock
        sut = CreateItemViewModel(uiConfig: CountersStub.getConfiguration(), createItemUseCase: createItemUseCase)
    }
    
    func test_initialStateIsNil() {
        XCTAssertNil(sut.state.value)
    }
    
    func test_stateIsFetching() {
        sut.createCount(withTitle: "a Title")
        XCTAssert(sut.state.value == .fetching)
    }
    
    func test_stateIsSucces() {
        let exp = expectation(description: "success")
        sut.createCount(withTitle: "a Title")
        createItemUseCase.completionWithSuccess()
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
        XCTAssert(sut.state.value == .success)
    }
    
    func test_stateIsFailure() {
        let exp = expectation(description: "error")
        sut.createCount(withTitle: "a Title")
        createItemUseCase.completionWithError()
        exp.fulfill()
        wait(for: [exp], timeout: 1.0)
        XCTAssert(sut.state.value == .failure(MockError.anError))
    }
    
    
    override func tearDown() {
        super.tearDown()
        dependencyStub = nil
        sut = nil
    }
    
}
