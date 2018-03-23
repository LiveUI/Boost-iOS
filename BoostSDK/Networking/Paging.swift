//
//  Paging.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


public struct Paging {
    
    let from: Int
    let limit: Int
    
    public init(from: Int = 0, limit: Int = 20) {
        self.from = from
        self.limit = limit
    }
    
}
