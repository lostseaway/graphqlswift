//
//  GraphQLBuilder.swift
//  GraphQLConnector
//
//  Created by TW-LostSeaWay on 9/5/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import Foundation

protocol GraphQLObject {
    init()
    func toGraphQL() -> String
    var className: String? { get set }
}

extension GraphQLObject {
    var className: String? { return nil }
    static func createQuery(param : [String:String]? = nil) -> String {
        let model = self.init()
        if param == nil {
            return "{\(model.toGraphQL())}".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
        }
        let strParam = generateParam(param: param!)
        return "{\(model.getClassName())(\(strParam)){\(model.getAllProperties().joined(separator: " "))}}".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
    }
    
    
    private static func generateParam(param: [String:String]) -> String {
        var out = [String]()
        param.forEach{ key , value in
            out.append("\(key):\"\(value)\"")
        }
        return out.joined(separator: ",")
    }
    
    func toGraphQL(className:String? = nil) -> String {
        let cName = className == nil ? getClassName() : className
        return "\(cName!){\(getAllProperties().joined(separator: " "))}"
    }
    
    func toGraphQL() -> String {
        let cName = className == nil ? getClassName() : className
        return "\(cName!){\(getAllProperties().joined(separator: " "))}"
    }
    
    
    private func getClassName() -> String {
        return "\(Mirror(reflecting: self).subjectType)"
    }
    
    private func getAllProperties() -> [String] {
        var properties = [String]()
        Mirror(reflecting: self).children.forEach({ property in
            if property.value is GraphQLObject {
                let tmp = (property.value) as! GraphQLObject
                properties.append(tmp.toGraphQL(className: property.label!))
            } else {
                properties.append(property.label!)
            }
        })
        return properties
    }
}

extension Array where Element: GraphQLObject {
    static func createQuery(bundleName: String) -> String {
        let model = Element.init()
        return "{\(bundleName){\(model.toGraphQL(className: nil))}}".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
    }
}
