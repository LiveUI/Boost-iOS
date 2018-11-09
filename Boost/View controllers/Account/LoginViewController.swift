//
//  LoginViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 21/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import MarcoPolo


class LoginViewController: GridViewController {
    
    typealias LoginClosure = ((_ email: String, _ password: String) -> Void)
    
    var login: LoginClosure
    
    var close: (() -> Void)
    
    lazy var emailField: TextField = {
        let tf = TextField()
        #if DEBUG
        tf.text = "core@liveui.io"
        #endif
        tf.placeholder = Lang.get("login.field.email.placeholder")
        tf.style.email()
        tf.nextField = passwordField
        return tf
    }()
    
    lazy var passwordField: TextField = {
        let tf = TextField()
        #if DEBUG
        tf.text = "sup3rS3cr3t"
        #endif
        tf.placeholder = Lang.get("login.field.password.placeholder")
        tf.style.password()
        tf.goButton = loginButton
        return tf
    }()
    
    lazy var loginButton: Button = {
        let b = Button(title: Lang.get("login.button.login"))
        b.action = { sender in
            if self.emailField.isValid, self.passwordField.isValid, let email = self.emailField.text, let password = self.passwordField.text {
                self.login(email, password)
            }
        }
        b.setTitleColor(.lightGray, for: .highlighted)
        return b
    }()
    
    // MARK: Initialization
    
    init(_ login: @escaping LoginClosure, close: @escaping (() -> Void)) {
        self.login = login
        self.close = close
        
        super.init()
    }
    
    // MARK: Elements
    
    override func setupElements() {
        super.setupElements()
        
        // Background
        setupColouredBackgroundView()
        
        // Nav bar
        let close = ButtonItem(UIImage(named: "navbar/menu-close"))
        close.addTarget(self, action: #selector(didTapClose(_:)), for: .touchUpInside)
        navigation.set(leftItem: close)
        
        // Content
        gridView.config.displayGrid = false
        
        gridView.add(subview: emailField, 120.0) { make in
            make.height.equalTo(44)
        }
        gridView.add(subview: passwordField, .below(emailField, margin: 20)) { make in
            make.height.equalTo(self.emailField)
        }
        gridView.add(subview: loginButton, .below(passwordField, margin: 20)) { make in
            make.height.equalTo(self.passwordField)
        }
    }
    
    // MARK: Actions
    
    @objc func didTapClose(_ sender: ButtonItem) {
        close()
    }
    
}
