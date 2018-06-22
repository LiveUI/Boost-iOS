//
//  LoginViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 21/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


class LoginViewController: GridViewController {
    
    typealias LoginClosure = ((_ email: String, _ password: String) -> Void)
    
    var login: LoginClosure
    
    lazy var emailField: TextField = {
        let tf = TextField()
        tf.keyboardType = .emailAddress
        tf.placeholder = Lang.get("login.field.email.placeholder")
        tf.validator = EmailValidator()
        tf.nextField = passwordField
        return tf
    }()
    
    lazy var passwordField: TextField = {
        let tf = TextField()
        tf.keyboardType = .asciiCapable
        tf.placeholder = Lang.get("login.field.password.placeholder")
        // TODO: Add show password button!
        tf.isSecureTextEntry = true
        tf.validator = NotEmptyValidator()
        tf.goButton = loginButton
        return tf
    }()
    
    lazy var loginButton: Button = {
        let b = Button.init(title: Lang.get("login.button.login"))
        b.action = { sender in
            if self.emailField.isValid, self.passwordField.isValid, let email = self.emailField.text, let password = self.passwordField.text {
                self.login(email, password)
            }
        }
        return b
    }()
    
    // MARK: Initialization
    
    init(_ login: @escaping LoginClosure) {
        self.login = login
        
        super.init()
    }
    
    // MARK: Elements
    
    override func setupElements() {
        super.setupElements()
        
        gridView.add(subview: emailField, 60.0) { make in
            make.height.equalTo(44)
        }
        gridView.add(subview: passwordField, .below(emailField, margin: 20)) { make in
            make.height.equalTo(self.emailField)
        }
        gridView.add(subview: loginButton, .below(passwordField, margin: 20)) { make in
            make.height.equalTo(self.passwordField)
        }
    }
    
}
