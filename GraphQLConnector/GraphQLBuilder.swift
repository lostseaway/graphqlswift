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
    var className: String? { get }
}

extension GraphQLObject {
    var className: String? { return nil }
    static func createQuery(param : [String:String]? = nil) -> String {
        let model = self.init()
        if param == nil {
            return "{\(model.toGraphQL())}"
        }
        let strParam = generateParam(param: param!)
        return "{\(model.getClassName())(\(strParam)){\(model.getAllProperties().joined(separator: " "))}}"
    }
    
    
    private static func generateParam(param: [String:String]) -> String {
        var out = [String]()
        param.forEach{ key , value in
            out.append("\(key):\"\(value)\"")
        }
        return out.joined(separator: ",")
    }
    
    func toGraphQL(className:String) -> String {
        return "\(className){\(getAllProperties().joined(separator: " "))}"
    }
    
    func toGraphQL() -> String {
        return "\(getClassName()){\(getAllProperties().joined(separator: " "))}"
    }
    
    private func getClassName() -> String {
        return className == nil ? "\(Mirror(reflecting: self).subjectType)" : className!
    }
    
    private func getAllProperties() -> [String] {
        var properties = [String]()
        Mirror(reflecting: self).children.forEach({ property in
            if property.value is GraphQLObject {
                let tmp = (property.value) as! GraphQLObject
                properties.append(tmp.toGraphQL())
            } else if property.label! != "className" {
                properties.append(property.label!)
            }
        })
        return properties
    }
}

extension Array where Element: GraphQLObject {
    static func createQuery(bundleName: String,param : [String:String]? = nil) -> String {
        let model = Element.init()
        if param == nil {
            return "{\(bundleName){\(model.toGraphQL())}}"
        }
        
        let strParam = generateParam(param: param!)
        return "{\(bundleName)(\(strParam)){\(model.toGraphQL())}}"
    }
    
    private static func generateParam(param: [String:String]) -> String {
        var out = [String]()
        param.forEach{ key , value in
            out.append("\(key):\"\(value)\"")
        }
        return out.joined(separator: ",")
    }
}
