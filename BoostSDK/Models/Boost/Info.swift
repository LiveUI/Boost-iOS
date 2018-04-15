//
//  Info.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct Info: Model {
    
    public let name: String
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
}
