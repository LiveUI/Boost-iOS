//
//  App.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 01/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


public struct App: Entry {
    
    public enum Platform: String, Codable, Queryable {
        case any
        case ios
        case android
        
        var key: String {
            return "platform"
        }
        
        var value: String? {
            switch self {
            case .any:
                return nil
            default:
                return rawValue
            }
        }
    }
    
    public let id: UUID?
    public let teamId: UUID?
    public let name: String
    public let identifier: String
    public let version: String
    public let build: String
    public let platform: Platform
    public let iconExists: Bool = false
    public let created: Date?
    public let modified: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamId = "team_id"
        case name
        case identifier
        case version
        case build
        case platform
        case iconExists = "icon"
        case created
        case modified
    }
    
}
