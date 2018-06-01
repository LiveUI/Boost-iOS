//
//  EmailValidator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


class EmailValidator: Validator {
    
    var maxCharacterCount: UInt = UInt.max
    
    func validate(_ value: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: value)
    }
    
    var invalidMessage: String = Lang.get("validation.field.invalid-email")
    
}
