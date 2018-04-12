//
//  Api+ApiCore.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Api {
    
    /// Get Pong on a Ping
    public func ping() throws -> Promise<Pong> {
        return try networking.get(path: "ping")
    }
    
}
