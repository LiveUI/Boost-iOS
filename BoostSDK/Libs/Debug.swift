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
        print("\n\n\n[\(request.httpMethod ?? "???")] request:\n\(request)")
        print("\(response.mimeType ?? "???") response:\n\(response)")
        print("Data:\n\(String(data: data, encoding: .utf8) ?? "unknown")\n\n")
    }
    
}
