//
//  Query.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


protocol Queryable {
    var key: String { get }
    var value: String? { get }
}


class Query {
    
    let path: String
    var parts: [String: String]
    
    // MARK: Initialization
    
    init(_ path: String, parts: [String: String] = [:]) {
        self.path = path
        self.parts = parts
    }
    
    // MARK: Settings
    
    func append(key: String, value: LosslessStringConvertible?) {
        guard let value = value else {
            return
        }
        parts[key] = "\(value)"
    }
    
    func append(_ elements: Queryable...) {
        for element in elements {
            append(key: element.key, value: element.value)
        }
    }
    
    // MARK: Output
    
    var value: String {
        let p: [String] = [path, parts.map({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")]
        return p.joined(separator: "?")
    }
    
}
