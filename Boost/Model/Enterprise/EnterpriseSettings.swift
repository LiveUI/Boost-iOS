//
//  EnterpriseSettings.swift
//  Boost
//
//  Created by Ondrej Rafaj on 05/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Reloaded


struct EnterpriseSettings: Codable {
    
    struct Account: Codable {
        
        let group: String?
        let deletable: Bool
        let name: String
        let server: String
        
    }
    
    let version: Int
    let accounts: [Account]
    
}

extension EnterpriseSettings {
    
    static func load() throws -> EnterpriseSettings? {
        guard let path = Bundle.main.path(forResource: "enterprise", ofType: "json") else {
            return nil
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(EnterpriseSettings.self, from: data)
    }
    
}

extension EnterpriseSettings.Account {
    
    @discardableResult func account() throws -> Account {
        let acc = try Account.new()
        acc.enterprise = true
        acc.update(from: self)
        try guaranteedGroup().addToAccounts(acc)
        return acc
    }
    
    func guaranteedGroup() throws -> Group {
        guard let groupName: String = group, let group = try Group.query.filter("name" == groupName).first() else {
            return try Group.new()
        }
        return group
    }
    
}
