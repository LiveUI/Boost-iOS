//
//  Api+Users.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 09/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Api {
    
    /// Get teams available to the user
    public func users() throws -> Promise<[User]> {
        return try networking.get(path: "users")
    }
    
    /// Get teams available to the user
    public func search(user: String) throws -> Promise<[User]> {
        return try networking.get(path: Query("users/search", parts: ["search": user]).value)
    }
    
    /// Get a single team
    public func user(_ id: UUID) throws -> Promise<User> {
        return try networking.get(path: "users/\(id.uuidString)")
    }
}

