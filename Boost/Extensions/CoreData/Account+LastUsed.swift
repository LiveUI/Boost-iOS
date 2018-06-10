//
//  Account+LastUsed.swift
//  Boost
//
//  Created by Ondrej Rafaj on 28/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Reloaded


extension Account {
    
    /// Set last used to now
    func updateLastUsed() throws {
        lastUsed = Date()
        try save()
    }
    
    /// Get last used account
    static func lastUsed() throws -> Account? {
        let last = try Account.query.filter("lastUsed" > Date(timeIntervalSince1970: 0)).sort(by: "lastUsed", direction: .orderedDescending).first()
        return last
    }
    
}
