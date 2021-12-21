//
//  CounterViewModelTests.swift
//  CountersTests
//
//  Created by Abner Abbey on 20/12/21.
//

import XCTest
@testable import Counters

class MainCounterViewModelTests: XCTestCase {
    
    var sut: MainCounterViewModel!
    var getCountUseCaseStub: GetCountUseCaseMock!
    var changeCountUseCaseStub: ChangeCountUseCaseMock!
    
    override func setUp() {
        super.setUp()
        getCountUseCaseStub = GetCountUseCaseMock()
        changeCountUseCaseStub = ChangeCountUseCaseMock()
        sut = MainCounterViewModel(uiConfig: CountersStub.getMainConfiguration(), getCountsUseCase: getCountUseCaseStub, changeCountUseCase: changeCountUseCaseStub)
    }
    
    func test_initalCountIsZero() {
        XCTAssertEqual(sut.count, 0)
    }
    
    func test_addNewCountIncrementsTheCount() {
        let count = sut.count
        sut.didAddNewCounter(CountersStub.getCount())
        XCTAssertEqual(sut.count, count + 1)
        XCTAssertTrue(sut.createdNewCounter.value ?? false)
    }
    
    func test_getCountersStateIsFetching() {
        sut.getCounters()
        XCTAssertEqual(sut.fetchState.value, .fetching)
    }
    
    func test_getCountersWithSuccess_isSuccessState() {
        let exp = expectation(description: "success")
        sut.getCounters()
        getCountUseCaseStub.completionWithSuccess()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssert(sut.fetchState.value == .success)
    }
    
    func test_getCountersWithSuccess_countIsNotZero() {
        let exp = expectation(description: "notZero")
        sut.getCounters()
        getCountUseCaseStub.completionWithSuccess()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssertNotNil(sut.count)
    }
    
    func test_getCountersWithError_countIsZero() {
        let exp = expectation(description: "zero")
        sut.getCounters()
        getCountUseCaseStub.completionWithFailure()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssertTrue(sut.count == 0)
    }
    
    func test_getCounters_withError() {
        let exp = expectation(description: "error")
        sut.getCounters()
        getCountUseCaseStub.completionWithFailure()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssert(sut.fetchState.value == .failure(MockError.anError))
    }
    
    func test_incrementCounters_withSuccess() {
        let exp = expectation(description: "increment")
        sut.didAddNewCounter(CountersStub.getCount())
        sut.performCounterOperation(withType: .increment, indexPath: IndexPath(row: 0, section: 0))
        changeCountUseCaseStub.completionWithSucces()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssert(sut.count > 0)
    }
    
    func test_incrementCounters_withFailure() {
        let exp = expectation(description: "increment")
        sut.didAddNewCounter(CountersStub.getCount())
        sut.performCounterOperation(withType: .increment, indexPath: IndexPath(row: 0, section: 0))
        changeCountUseCaseStub.completionWithError()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssertNotNil(sut.count == 0)
    }
    
    func test_decrementCounters_withSuccess() {
        let exp = expectation(description: "decerement")
        sut.didAddNewCounter(CountersStub.getCount())
        sut.performCounterOperation(withType: .decrement, indexPath: IndexPath(row: 0, section: 0))
        changeCountUseCaseStub.completionWithSucces()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssert(sut.count > 0)
    }
    
    func test_decrementCounters_withFailure() {
        let exp = expectation(description: "decrement")
        sut.didAddNewCounter(CountersStub.getCount())
        sut.performCounterOperation(withType: .decrement, indexPath: IndexPath(row: 0, section: 0))
        changeCountUseCaseStub.completionWithError()
        exp.fulfill()
        wait(for: [exp], timeout: 0.3)
        XCTAssertNotNil(sut.count == 0)
    }
    
    func test_filtering_withSuccess() {
        sut.didAddNewCounter(CountersStub.getCount())
        sut.search(withText: "new")
        XCTAssertTrue(sut.filtered.value!.count > 0)
    }
    
    func test_filtering_withFailure() {
        sut.didAddNewCounter(CountersStub.getCount())
        sut.search(withText: "hello")
        XCTAssertTrue(sut.filtered.value!.count == 0)
    }
    
    
    
    override func tearDown() {
        super.tearDown()
        getCountUseCaseStub = nil
        changeCountUseCaseStub = nil
        sut = nil
    }
    
    // MARK: - Helper functions

}
