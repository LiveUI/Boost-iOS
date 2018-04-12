//
//  Overview.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct Overview: Codable {
    
    public let platform: App.Platform
    public let identifier: String
    public let count: Int
    
    enum CodingKeys: String, CodingKey {
        case platform
        case identifier
        case count
    }
    
}
