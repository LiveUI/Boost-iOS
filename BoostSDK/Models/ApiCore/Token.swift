//
//  Token.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct Token: Entry {
    
    struct Request: Codable {
        let token: UUID
    }
    
    public let id: UUID?
    public let expires: String
    public let user: User
    
    enum CodingKeys: String, CodingKey {
        case expires
        case id
        case user
    }
}

