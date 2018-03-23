//
//  Api.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


public struct Api {
    
    func getAppFileTemp(name: String = "all") -> [App] {
        let path = Bundle.main.path(forResource: "apps-\(name)", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: [])
        let apps = try! JSONDecoder().decode([App].self, from: data)
        return apps
    }
    
}
