//
//  Boost.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation


public struct Config {
    
    let baseUrl: URL = URL(string: "http://api.appstorehq.net")!
    
}


public class Boost {
    
    let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
}
