//
//  GraphQLConnectorTests.swift
//  GraphQLConnectorTests
//
//  Created by TW-LostSeaWay on 9/5/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import XCTest
@testable import GraphQLConnector

class GraphQLConnectorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSimpleQuery() {
        XCTAssertEqual(Person.createQuery(), htmlEncode(str: "{Person{name age}}"))
    }
    
    func testQueryWithParam() {
        XCTAssertEqual(Person.createQuery(className: nil, param: ["name":"Dream"]), htmlEncode(str: "{Person(name:\"Dream\"){name age}}"))
    }
    
    func testNestedQuery() {
        let query = Car.createQuery(className: nil, param: ["brand":"Honda"])
        XCTAssertEqual(query, htmlEncode(str: "{Car(brand:\"Honda\"){color brand owner{name age}}}"))
    }
    
    func testBundleQuery() {
        XCTAssertEqual([Person].createQuery(bundleName: "allpeople"), htmlEncode(str: "{allpeople{Person{name age}}}"))
    }
    
    private func htmlEncode(str: String) -> String {
        return str.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
    }
    
}

private extension Client {
    struct TestRequst: RequestConstructable  {
        var baseURL: URL = URL(string: base)!
    }
}
