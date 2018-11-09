//
//  Style+Input.swift
//  Boost
//
//  Created by Ondrej Rafaj on 08/11/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension StylesProperty where ElementType: UIView, ElementType: FormElement {
    
    func basic() {
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.white.cgColor
        element.layer.cornerRadius = 10
        
        element.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
}


extension StylesProperty where ElementType: TextField {
    
    func basicTextField() {
        basic()
        
        element.textColor = .white
    }
    
    func email() {
        basicTextField()
        
        element.keyboardType = .emailAddress
        element.autocorrectionType = .no
        element.autocapitalizationType = .none
        element.validator = EmailValidator()
    }
    
    func password() {
        basicTextField()
        
        element.keyboardType = .asciiCapable
        element.autocorrectionType = .no
        element.autocapitalizationType = .none
        // TODO: Add show password button!
        element.isSecureTextEntry = true
        element.validator = NotEmptyValidator()
    }
    
}
