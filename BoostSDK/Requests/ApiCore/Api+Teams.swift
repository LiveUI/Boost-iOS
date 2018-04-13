//
//  Api+Teams.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Api {
    
    /// Get teams available to the user
    public func teams() throws -> Promise<[Team]> {
        return try networking.get(path: "teams")
    }
    
    /// Get a single team
    public func team(_ id: UUID) throws -> Promise<Team> {
        return try networking.get(path: "teams/\(id.uuidString)")
    }
    
    /// Check if team identifier is available
    public func check(teamIdentifier identifier: String) throws -> Promise<Bool> {
        let check = Team.Check(identifier: identifier)
        let success: Promise<Success> = try networking.post(path: "teams/check", object: check)
        let promise = Promise<Bool>()
        try success.then({ success in
            promise.complete(true)
        }).error({ error in
            promise.complete(false)
        })
        return promise
    }
    
    /// Create a team
    public func create(team: Team) throws -> Promise<Team> {
        return try networking.post(path: "teams", object: team)
    }
    
    /// Update a single team
    public func update(team: Team) throws -> Promise<Team> {
        guard let id = team.id else {
            throw Problem.objectHasntBeenCreatedYet
        }
        return try networking.put(path: "teams/\(id.uuidString)", object: team)
    }
    
    /// Delete a single team
    public func team(_ id: UUID) throws -> Promise<Void> {
        return try networking.delete(path: "teams/\(id.uuidString)")
    }
    
}
