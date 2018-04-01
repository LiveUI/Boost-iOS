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
        let promise = Promise<Info>()
        try networking.get(path: "info") { (login) in
            do {
                let object = try login.unwrap(to: Info.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
}
