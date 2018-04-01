//
//  Codable+Tools.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Encodable {
    
    func asData() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
    
}


extension Data {
    
    func asObject<T>(to: T.Type) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(to, from: self)
    }
    
}
