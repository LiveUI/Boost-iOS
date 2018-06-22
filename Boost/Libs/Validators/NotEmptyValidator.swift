//
//  NotEmptyValidator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


class NotEmptyValidator: Validator {
    
    var maxCharacterCount: UInt = UInt.max
    
    func validate(_ value: String) -> Bool {
        return !value.isEmpty
    }
    
    var invalidMessage: String = Lang.get("validation.field.is-empty")
    
}
