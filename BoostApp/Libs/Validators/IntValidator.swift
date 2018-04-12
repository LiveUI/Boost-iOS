//
//  IntValidator.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


class IntValidator: Validator {
    
    var maxCharacterCount: UInt = 20
    
    func validate(_ value: String) -> Bool {
        return Int(value) != nil
    }
    
    var invalidMessage: String = Lang.get("validation.field.not-int")
    
}
