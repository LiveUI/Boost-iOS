//
//  Api+Boost.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Api {
    
    /// Information about the API
    public func info() throws -> Promise<Info> {
        return try networking.get(path: "info")
    }
    
}
