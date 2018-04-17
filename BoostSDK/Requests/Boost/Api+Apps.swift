//
//  Api+Apps.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


extension Api {
    
    /// Return promise for a list of available app identifiers per each platform
    public func info(team teamId: UUID) throws -> Promise<TeamAppInfo> {
        let query: Query
        query = Query("teams/\(teamId)/apps/info")
        return try networking.get(path: query.value)
    }
    
    /// Return promise for a list of available app identifiers per each platform
    public func overview(team teamId: UUID? = nil, platform: App.Platform = .any, identifier: String? = nil, page: Int = 0, limit: Int = 1000) throws -> Promise<[Overview]> {
        let query: Query
        if let teamId = teamId {
            query = Query("teams/\(teamId)/apps/overview")
        } else {
            query = Query("apps/overview")
        }
        query.append(platform)
        query.append(key: "identifier", value: identifier)
        query.append(key: "page", value: page)
        query.append(key: "limit", value: limit)
        return try networking.get(path: query.value)
    }
    
    // TODO: Add sorting!!!!!!!
    /// Return promise for apps with optional basic filters
    /// Property `search` is for basic searching with name, info, version, bundle and identifier being looked through
    public func apps(team teamId: UUID? = nil, platform: App.Platform = .any, identifier: String? = nil, search: String? = nil, page: Int = 0, limit: Int = 30) throws -> Promise<[App]> {
        let query: Query
        if let teamId = teamId {
            query = Query("teams/\(teamId)/apps")
        } else {
            query = Query("apps")
        }
        query.append(platform)
        query.append(key: "identifier", value: identifier)
        query.append(key: "page", value: page)
        query.append(key: "limit", value: limit)
        query.append(key: "search", value: search)
        return try networking.get(path: query.value)
    }
    
}
