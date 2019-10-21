//
//  CERandomTests.swift
//  CERandomTests
//
//  Created by Mohammad Arafat Hossain on 21/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import XCTest
@testable import CERandom

public class CEBaseTestCase: XCTestCase {
    let service = MockService()
    
    override public func setUp() {
        super.setUp()
    }
    override public func tearDown() {
        super.tearDown()
    }
    func testPerformanceExample() {
        self.measure { }
    }
}

extension CEBaseTestCase {
    static let succeded = "Success"
    static let failed = "Failed"
    static let search = "Search"
}


public class MockService: CEServiceProtocol {
    func fetchPeople(for params: CEStringDictionary,
                     completion: @escaping(CEServiceReply<Random, CEError>) -> Void) {
        
        let name = Random.Person.Name(title: "", first: "", last: "")
        let dob = Random.Person.Dob(date: Date(), age: 0.3)
        let pic = Random.Person.Picture(large: "", thumbnail: "")
        let per = Random.Person(gender: "", nat: "", email: "", name: name, dob: dob, picture: pic)
        let page = Random.Page(items: 5, number: 15)
        let rand = Random(persons: [per], page: page)
        completion(CEServiceReply.success(rand))
    }
    func downloadImage(for url: String,
                       completion: @escaping (CEServiceReply<UIImage, CEError>) -> Void) {
        completion(CEServiceReply.success(UIImage()))
    }
    func fetchPeopleFromCoreData(completion: @escaping(CEServiceReply<[Random.Person], CEError>) -> Void) {
        completion(CEServiceReply.failure(CEError.network))
    }
}

