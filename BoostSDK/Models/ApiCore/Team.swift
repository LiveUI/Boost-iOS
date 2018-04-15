//
//  Team.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct Team: Entry {
    
    struct Check: Codable {
        let identifier: String
    }
    
    public let id: UUID?
    public let admin: Bool
    public let name: String
    public let identifier: String
    public let initials: String
    public let color: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case admin
        case name
        case identifier
        case initials
        case color
    }
}

