//
//  User.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct User: Entry {
    
    public let id: UUID?
    public let lastname: String
    public let registered: String
    public let firstname: String
    public let username: String
    public let email: String
    public let su: Bool
    public let disabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastname
        case registered
        case firstname
        case username
        case email
        case su
        case disabled
    }
    
}


extension User {
    
    public var avatarUrl: String {
        return "https://www.gravatar.com/avatar/\(email)"
    }
    
}
