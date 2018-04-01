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
    
    static func post(data: Data) {
        print("POST data: \(String(data: data, encoding: .utf8) ?? "unknown")")
    }
    
    static func post(request: URLRequest) {
        print("\(request.httpMethod ?? "???") request: \(request)")
    }
    
    static func post(response: URLResponse) {
        print("\(response.mimeType ?? "???") request: \(response)")
    }
    
}
