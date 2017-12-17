//
//  Boost.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation


public struct Config {
    
    public let baseUrl: URL = URL(string: "http://api.appstorehq.net")!
    
}


public struct Boost {
    
    static public let config = Config()
    
    static public let api = Api()
    
}
