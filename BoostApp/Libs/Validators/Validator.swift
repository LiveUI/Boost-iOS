//
//  Validator.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


protocol Validator {
    var maxCharacterCount: UInt { get }
    var invalidMessage: String { get }
    func validate(_ value: String) -> Bool
}


extension Validator {
    
    var invalidMessage: String {
        return Lang.get("validation.field.default.invalid")
    }
    
}


protocol Validatable {
    var isValid: Bool { get }
    func checkIsValid(_ value: String?)
}
