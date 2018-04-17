//
//  Overview.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct Overview: Model {
    
    public var latestName: String
    public var latestVersion: String
    public var latestBuild: String
    public let platform: App.Platform
    public let identifier: String
    public let count: Int
    
    enum CodingKeys: String, CodingKey {
        case latestName = "latest_name"
        case latestVersion = "latest_version"
        case latestBuild = "latest_build"
        case platform
        case identifier
        case count
    }
    
}
