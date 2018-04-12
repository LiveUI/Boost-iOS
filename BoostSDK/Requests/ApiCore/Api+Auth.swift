//
//  Api+Auth.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Api {
    
    /// Authentication with username and password
    public func auth(email: String, password: String) throws -> Promise<Login> {
        let data = Login.Request(email: email, password: password)
        return try networking.post(path: "auth", object: data)
    }
    
    /// Authentication refresh using persistent token
    public func auth(token: UUID) throws -> Promise<Token> {
        let data = Token.Request(token: token)
        return try networking.post(path: "token", object: data)
    }
    
}
