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
        XCTAssertEqual(Person.createQuery(), "{Person{name age}}")
    }
    
    func testQueryWithParam() {
        XCTAssertEqual(Person.createQuery(param: ["name":"Dream"]), "{Person(name:\"Dream\"){name age}}")
    }
    
    func testNestedQuery() {
        let query = Car.createQuery(param: ["brand":"Honda"])
        XCTAssertEqual(query, "{Car(brand:\"Honda\"){color brand Person{name age}}}")
    }
    
    func testBundleQuery() {
        XCTAssertEqual([Person].createQuery(bundleName: "allpeople"), "{allpeople{Person{name age}}}")
    }
    
    func testBundleQueryWithParam() {
        XCTAssertEqual([Person].createQuery(bundleName: "allpeople", param: ["from":"1"]) , "{allpeople(from:\"1\"){Person{name age}}}")
    }
    
    func testClassName() {
        XCTAssertEqual(Hero.createQuery(), "{person{id name}}")
    }
    
    func testClassNameBundle() {
        XCTAssertEqual([Hero].createQuery(bundleName: "allpeople"),"{allpeople{person{id name}}}")
    }
    
    func testClassNameBundleWithParam() {
        XCTAssertEqual([Hero].createQuery(bundleName: "allpeople",param: ["from":"1"]), "{allpeople(from:\"1\"){person{id name}}}")
    }

}


