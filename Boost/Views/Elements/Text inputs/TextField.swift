//
//  TextField.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import AwesomeEnum
import Base


// TODO: Comment / clean
class TextField: UITextField, UITextFieldDelegate, Validatable, FormElement {
    
    var validator: Validator? {
        didSet {
            delegate = self
            
            guard let validator = validator else {
                return
            }
            if validator.maxCharacterCount < UInt.max {
//                underlineController?.characterCountMax = validator.maxCharacterCount
            }
        }
    }
    
    var nextField: TextField?
    var goButton: UIButton? {
        didSet {
            returnKeyType = .go
        }
    }
    
    // MARK: Settings
    
    override var text: String? {
        get {
            return super.text
        }
        set {
            super.text = newValue
            checkIsValid()
        }
    }
    
    func setGoButton(_ button: UIButton, returnKeyType: UIReturnKeyType) {
        goButton = button
        self.returnKeyType = returnKeyType
    }
    
    // MARK: Initialization
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    /// Not implemented
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        sizeToFit()
    }
    
    // MARK: Validation
    
    var isValid: Bool {
        guard let validator = validator else {
            return true
        }
        return validator.validate(text ?? "")
    }
    
    func checkIsValid(_ value: String? = nil) {
//        guard let validator = validator else {
//            return
//        }
//        
//        let isValid = validator.validate(value ?? text ?? "")
//        let errorText: String? = (isValid ? nil : validator.invalidMessage)
//        underlineController?.setErrorText(errorText, errorAccessibilityValue: nil)
    }
    
    // MARK: Delegate methods
    
    var canStartValidatingChanges: Bool = false
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isValid {
            textField.resignFirstResponder()
            
            nextField?.becomeFirstResponder()
            goButton?.sendActions(for: .touchUpInside)
        } else {
            checkIsValid()
        }
        
        canStartValidatingChanges = true
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if canStartValidatingChanges {
            let futureText = NSString(string: text ?? "").replacingCharacters(in: range, with: string)
            checkIsValid(futureText)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        checkIsValid()
        
        canStartValidatingChanges = true
    }
    
}


struct TextFieldValidation {
    
    let element: TextField
    
    
    // MARK: Validations
    
    func notEmpty() {
        element.validator = NotEmptyValidator()
    }
    
    func serverName() {
        element.validator = ServerNameValidator()
    }
    
    func email() {
        element.validator = EmailValidator()
    }
    
    func int() {
        element.validator = IntValidator()
    }
    
    func url() {
        element.validator = UrlValidator()
    }
    
    // MARK: Initialization
    
    init(_ element: TextField) {
        self.element = element
    }
    
}


extension TextField {
    
    var validate: TextFieldValidation {
        return TextFieldValidation(self)
    }
    
}
