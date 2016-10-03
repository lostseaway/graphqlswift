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
        let peopleQuery = PeopleQuery(label: "people", fields: [.id,.name], arguments: nil)
        XCTAssertEqual("{\(peopleQuery.serialized())}" , "{people {id name}}")
    }
    
    func testQueryWithParam() {
        let peopleQuery = PeopleQuery(label: "people", fields: [.id,.name], arguments: [.id("1")])
        XCTAssertEqual("{\(peopleQuery.serialized())}", "{people(id:\"1\") {id name}}")
    }
    
    func testNestedQuery() {
        let peopleQuery = PeopleQuery(label: "people", fields: [.id,.name], arguments: nil)
        let allQuery = AllPeopleQuery(label: "allPeople", fields: [.people(peopleQuery)], arguments: nil)
        XCTAssertEqual("{\(allQuery.serialized())}", "{allPeople {people {id name}}}")
    }
    
    func testNestedQueryWithParam() {
        let peopleQuery = PeopleQuery(label: "people", fields: [.id,.name], arguments: [.id("1")])
        let allQuery = AllPeopleQuery(label: "allPeople", fields: [.people(peopleQuery)], arguments: [.first(1)])
        XCTAssertEqual("{\(allQuery.serialized())}", "{allPeople(first:\"1\") {people(id:\"1\") {id name}}}")
    }

}


