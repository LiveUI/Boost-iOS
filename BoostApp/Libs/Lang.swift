//
//  Lang.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 01/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


class Lang {
    
    static func get(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
    
}
