//
//  App.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 01/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation


public struct App: Codable {
    
    public enum Platform: Int, Codable {
        case file = 0
        case ios = 1
        case tvos = 2
        case android = 3
    }
    
    public let id: Int?
    public let teamId: Int?
    public let name: String
    public let identifier: String
    public let version: String
    public let build: String
    public let platform: Platform
    public let created: Date?
    public let modified: Date?
    public let availableToAll: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamId = "team_id"
        case name
        case identifier
        case version
        case build
        case platform
        case created
        case modified
        case availableToAll = "basic"
    }
    
}
