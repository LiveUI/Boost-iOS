//
//  Pong.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct Pong: Model {
    
    public let code: String
    
}


extension Pong {
    
    public func validate() -> Bool {
        return code == "pong"
    }
    
}
