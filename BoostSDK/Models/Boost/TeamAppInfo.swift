//
//  TeamAppInfo.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct TeamAppInfo: Model {
    
    public let apps: String
    public let builds: Int
    
    enum CodingKeys: String, CodingKey {
        case apps
        case builds
    }
    
}
