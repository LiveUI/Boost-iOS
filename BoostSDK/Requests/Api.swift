//
//  Api.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


public class Api {
    
    /// Api errors
    public enum Problem: Error {
        case badServerUrl
        case notAuthorized
        case missingAuthToken
        case objectHasntBeenCreatedYet
    }
    
    /// Configuration object
    public struct Config {
        
        /// Server URL
        public let serverUrl: String
        
        // TODO: Make token UUID!!
        /// Persistent authentication token
        public var token: String?
        
        /// Initializer
        public init(serverUrl: String, token: String? = nil) {
            self.serverUrl = serverUrl
            self.token = token
        }
        
    }
    
    /// Configuration
    public var config: Config
    
    /// Networking
    let networking: Networking
    
    /// Initialization
    public init(config: Config) throws {
        self.config = config
        
        guard let url = URL(string: config.serverUrl) else {
            throw Problem.badServerUrl
        }
        
        networking = Networking(baseUrl: url)
        networking.reauthenticate = {
            guard let token = config.token, let uuid = UUID(uuidString: token) else {
                throw Problem.missingAuthToken
            }
            return try self.auth(token: uuid)
        }
    }
    
}
