//
//  LoginViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular
import Reloaded
import BoostSDK
import AwesomeEnum


class LoginViewController: ViewController {
    
    var requestedChangeAccountName: ((_ account: Account) -> Void)?
    
    let serverField = TextField()
    let loginField = TextField()
    let passwordField = TextField()
    let actionButton = PrimaryButton()
    
    var account: Account? {
        didSet {
            DispatchQueue.main.async {
                self.serverField.isEnabled = false
                self.loginField.isEnabled = false
                self.passwordField.isEnabled = false
            }
        }
    }
    
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
        
        let close = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose(_:)))
        navigationItem.leftBarButtonItem = close
        
        serverField.placeholder = Lang.get("login.step1.server.placeholder")
        serverField.validate.url()
        serverField.nextField = loginField
        serverField.place.on(view, top: 84).sideMargins()
        
        loginField.icon = Awesome.solid.envelope
        loginField.placeholder = Lang.get("login.step1.username.placeholder")
        loginField.validate.email()
        loginField.nextField = passwordField
        loginField.place.below(serverField, top: 12).match(height: serverField).match(left: serverField).match(right: serverField)
        
        passwordField.icon = Awesome.solid.key
        passwordField.placeholder = Lang.get("login.step1.password.placeholder")
        passwordField.validate.notEmpty()
        passwordField.isSecureTextEntry = true
        passwordField.goButton = actionButton
        passwordField.place.below(loginField, top: 12).match(height: serverField).match(left: serverField).match(right: serverField)
        
        actionButton.setTitle(Lang.get("login.step1.login"), for: .normal)
        actionButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        actionButton.place.below(passwordField, top: 22).centerX()
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if account != nil {
            actionButton.setTitle(Lang.get("login.step1.change_name"), for: .normal)
        } else {
            serverField.becomeFirstResponder()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if account == nil {
            serverField.becomeFirstResponder()
        }
        
        #if DEBUG
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let prefill = UIBarButtonItem(title: "Demo", style: .plain, target: self, action: #selector(self.prefill(_:)))
            self.navigationItem.setRightBarButton(prefill, animated: true)
        }
        #endif
    }
    
    // MARK: Actions
    
    @objc func prefill(_ sender: UIBarButtonItem) {
        serverField.text = "http://localhost:8080"
        loginField.text = "admin@liveui.io"
        passwordField.text = "admin"
    }
    
    @objc func didTapClose(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        if let account = account {
            requestedChangeAccountName?(account)
        } else {
            guard validate(), let server = serverField.text, let email = loginField.text, let password = passwordField.text else {
                return
            }
            
            do {
                let api = try Api(config: Api.Config(serverUrl: server))
                try api.auth(email: email, password: password).then { (login) in
                    try api.info().then({ info in
                        guard !info.url.isEmpty else {
                            // TODO: Handle as an error!!!!
                            print("Empty server URL :(")
                            return
                        }
                        let account = try Account.new()
                        account.name = info.name
                        account.server = info.url
                        account.token = login.token
                        try account.save()
                        
                        self.account = account
                        
                        DispatchQueue.main.async {
                            self.requestedChangeAccountName?(account)
                        }
                    })
                }
            } catch {
                Dialog.show(error: error, on: self)
            }
        }
    }
    
}
