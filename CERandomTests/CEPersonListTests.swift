//
//  CERandomTests.swift
//  CERandomTests
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import XCTest

final class CEPersonListTests: CEBaseTestCase {
    private var personViewModel: CEPersonViewModel?
    fileprivate let context = MockView()
    
    override func setUp() {
        super.setUp()
        
        personViewModel = CEPersonViewModel(context: context, service)
    }
    override func tearDown() {
        super.tearDown()
        
        personViewModel = nil
    }
    
    func testSearchFromList() {
        context.expect(expectation(description: CEBaseTestCase.search))
        personViewModel?.startSearching(for: "Test..")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testSuccessNetworking() {
        context.expect(expectation(description: CEBaseTestCase.succeded))
        personViewModel?.startLiveLoading()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testFailedCoredata() {
        context.expect(expectation(description: CEBaseTestCase.failed))
        personViewModel?.startStoredLoading()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testDownloadImage() {
        personViewModel?.getImage(from: "") { (image: UIImage?) in
            guard let pic = image else {
                XCTFail()
                return
            }
            XCTAssertNotNil(pic)
        }
    }
}

// MARK: View Context
fileprivate class MockView: CEListContextProtocol {
    private var expectations: [XCTestExpectation] = []
    
    private func fulfill(_ expectation: String)  {
        _ = expectations
            .filter { $0.description == expectation }
            .compactMap { $0.fulfill() }
    }
    
    fileprivate func expect(_ expectation: XCTestExpectation) {
        expectations.append(expectation)
    }
    
    func didFailFetching(with reason: String) {
        fulfill(CEBaseTestCase.failed)
    }
    func didSuccessFetching(with indexSet: [IndexPath]?) {
        fulfill(CEBaseTestCase.succeded)
    }
    func didFindSearch(list indexSet: [IndexPath]?) {
        fulfill(CEBaseTestCase.search)
    }
}
