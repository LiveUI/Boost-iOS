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
        let promise = Promise<Login>()
        let data = Login.Request(email: email, password: password)
        try networking.post(path: "auth", object: data) { (login) in
            do {
                let object = try login.unwrap(to: Login.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
    /// Authentication refresh using persistent token
    public func auth(token: String) throws -> Promise<Token> {
        let promise = Promise<Token>()
        let data = Token.Request(token: token)
        try networking.post(path: "token", object: data) { (token) in
            do {
                let object = try token.unwrap(to: Token.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
}
