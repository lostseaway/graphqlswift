//
//  Person.swift
//  GraphQLConnector
//
//  Created by TW-LostSeaWay on 9/5/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import Foundation
import Gloss

enum PeopleArgument: Argument {
    case id(String), personID(String)
    
    func serialized() -> String {
        switch self {
        case .id(let value):
            return createArgument(key: "id", value: value)
        case .personID(let value):
            return createArgument(key: "personID", value: value)
        }
    }
}

enum PeopleField: Field {
    case id, name, birthYear, eyeColor, gender, hairColor
    
    func serialized() -> String {
        switch self {
        case .id:
            return "id"
        case .name:
            return "name"
        case .birthYear:
            return "birthYear"
        case .eyeColor:
            return "eyeColor"
        case .gender:
            return "gender"
        case .hairColor:
            return "hairColor"
        }
    }
}

struct PeopleQuery: QueryObject {
    var label: String = "people"
    var fields: [PeopleField]
    var arguments: [PeopleArgument]?
}

struct People: Decodable {
    let id: String
    let name: String
    init?(json: JSON) {
        self.id = ("id" <~~ json)!
        self.name = ("name" <~~ json)!
    }
}

enum AllPeopleArgument: Argument {
    case after(String), first(Int), before(String), last(Int)
    
    func serialized() -> String {
        switch self {
        case .after(let value):
            return createArgument(key: "after", value: value)
        case .first(let value):
            return createArgument(key: "first", value: "\(value)")
        case .before(let value):
            return createArgument(key: "before", value: value)
        case .last(let value):
            return createArgument(key: "last", value: "\(value)")
        }
    }
}

enum AllPeopleField: Field {
    case totalCount, people(PeopleQuery)
    
    func serialized() -> String {
        switch self {
        case .totalCount:
            return "totalCount"
        case .people(let peopleQuery):
            return peopleQuery.serialized()
        }
    }
}


struct AllPeopleQuery: QueryObject {
    var label: String = "allPeople"
    var fields: [AllPeopleField]
    var arguments: [AllPeopleArgument]?
}

