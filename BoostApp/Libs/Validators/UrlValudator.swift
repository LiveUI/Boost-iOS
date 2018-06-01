
//
//  UrlValudator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


class UrlValidator: Validator {
    
    var maxCharacterCount: UInt = UInt.max
    
    func validate(_ value: String) -> Bool {
        return URL(string: value) != nil
    }
    
    var invalidMessage: String = Lang.get("validation.field.invalid-url")
    
}
