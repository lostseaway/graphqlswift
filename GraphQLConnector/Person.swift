//
//  Person.swift
//  GraphQLConnector
//
//  Created by TW-LostSeaWay on 9/5/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import Foundation
struct Person: GraphQLObject {
    var name: String
    var age: Int
    init() {
        self.name = ""
        age = 0
    }
}

struct Car: GraphQLObject {
    let color: String
    let brand: String
    let owner: Person
    init() {
        color = ""
        brand = ""
        owner = Person()
    }
}


