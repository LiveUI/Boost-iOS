//
//  Debug.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


class Debug {
    
    static func print(_ message: String) {
        Swift.print("Debug: \(message)")
    }
    
    static func request(_ request: URLRequest, response: URLResponse, data: Data) {
        print("\(request.httpMethod ?? "???") request: \(request)")
        print("\(response.mimeType ?? "???") response: \(response)")
        print("Data: \(String(data: data, encoding: .utf8) ?? "unknown")")
    }
    
}
