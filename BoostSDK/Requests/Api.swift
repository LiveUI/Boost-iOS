//
//  Api.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


public struct Api {
    
    /// Api errors
    public enum Problem: Error {
        case badServerUrl
        case notAuthorized
    }
    
    /// Configuration object
    public struct Config {
        
        /// Server URL
        public let serverUrl: String
        
        /// Initializer
        public init(serverUrl: String) {
            self.serverUrl = serverUrl
        }
        
    }
    
    /// Configuration
    public let config: Config
    
    /// Networking
    let networking: Networking
    
    /// Initialization
    public init(config: Config) throws {
        self.config = config
        
        guard let url = URL(string: config.serverUrl) else {
            throw Problem.badServerUrl
        }
        self.networking = Networking(baseUrl: url)
    }
    
    // MARK: Getters
    
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
    
//    func getAppFileTemp(name: String = "all") -> [App] {
//        let path = Bundle.main.path(forResource: "apps-\(name)", ofType: "json")!
//        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: [])
//        let apps = try! JSONDecoder().decode([App].self, from: data)
//        return apps
//    }
    
}
