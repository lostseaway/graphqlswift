//
//  GraphQLBuilder.swift
//  GraphQLConnector
//
//  Created by TW-LostSeaWay on 9/5/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import Foundation

protocol Query {
    func serialized() -> String
}

protocol Field: Query {
    
}

protocol Argument: Query {
    
}

extension Argument {
    func createArgument(key: String, value: String) -> String {
        return "\(key):\"\(value)\""
    }
}

protocol QueryObject: Query {
    associatedtype FieldType: Field
    associatedtype ArgumentType: Argument
    
    var label: String { get }
    var fields: [FieldType] { get }
    var arguments: [ArgumentType]? { get }
}

extension QueryObject {
    func serialized() -> String {
        if arguments == nil {
            return "\(label) {\(fields.map({ $0.serialized() }).joined(separator: " "))}"
        }

        return "\(label)(\(arguments!.map({"\($0.serialized())"}).joined(separator: ","))) {\(fields.map({ $0.serialized() }).joined(separator: " "))}"
    }
}
