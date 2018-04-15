//
//  Login.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct Login: Entry {
    
    struct Request: Codable {
        let email: String
        let password: String
    }
    
    public let id: UUID?
    public let expires: String
    public let token: String
    public let user: User
    
    enum CodingKeys: String, CodingKey {
        case expires
        case id
        case token
        case user
    }
}

