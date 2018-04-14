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
    
    enum Mode {
        case newAccount
        case login
    }
    
    var requestedNextStep: ((_ account: Account) -> Void)?
    
    let serverField = TextField()
    let loginField = TextField()
    let passwordField = TextField()
    let actionButton = PrimaryButton()
    
    var account: Account? {
        didSet {
            DispatchQueue.main.async {
                if self.mode == .newAccount {
                    self.serverField.isEnabled = false
                    self.loginField.isEnabled = false
                    self.passwordField.isEnabled = false
                }
            }
        }
    }
    
    var mode: Mode
    
    
    // MARK: Initialization
    
    init(mode: Mode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
        
        if self.mode == .newAccount {
            title = Lang.get("login.new_acc_title")
        } else {
            title = Lang.get("login.login_title")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
        
        let close = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose(_:)))
        navigationItem.leftBarButtonItem = close
        
        if self.mode == .newAccount {
            serverField.placeholder = Lang.get("login.server.placeholder")
            serverField.validate.url()
            serverField.nextField = loginField
            serverField.place.on(view, top: 84).sideMargins()
            
            loginField.place.below(serverField, top: 12).match(height: serverField).match(left: serverField).match(right: serverField)
        } else {
            loginField.place.on(view, top: 84).sideMargins()
        }
        
        loginField.icon = Awesome.solid.envelope
        loginField.placeholder = Lang.get("login.username.placeholder")
        loginField.validate.email()
        loginField.nextField = passwordField
        
        passwordField.icon = Awesome.solid.key
        passwordField.placeholder = Lang.get("login.password.placeholder")
        passwordField.validate.notEmpty()
        passwordField.isSecureTextEntry = true
        passwordField.goButton = actionButton
        passwordField.place.below(loginField, top: 12).match(height: loginField).match(left: loginField).match(right: loginField)
        
        actionButton.setTitle(Lang.get("login.login"), for: .normal)
        actionButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        actionButton.place.below(passwordField, top: 22).centerX()
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        actionButton.isEnabled = true
        
        if account != nil && mode != .login {
            actionButton.setTitle(Lang.get("login.change_name"), for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if mode == .login {
            loginField.becomeFirstResponder()
        } else {
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
        guard validate(), let email = loginField.text, let password = passwordField.text else {
            return
        }
        do {
            if let account = account {
                try runLogin(account: account, email: email, password: password)
            } else {
                try runNewAccount(email: email, password: password)
            }
        } catch {
            actionButton.isEnabled = true
            Dialog.show(error: error, on: self)
        }
    }
    
    private func runLogin(account: Account, email: String, password: String) throws {
        actionButton.isEnabled = false
        
        let api = try Api(config: Api.Config(serverUrl: account.server!))
        try api.auth(email: email, password: password).then { (login) in
            account.token = login.token
            
            DispatchQueue.main.async {
                try? account.save()
                self.requestedNextStep?(account)
            }
            }.error({ error in
                self.fail(error: error)
            })
    }
    
    private func runNewAccount(email: String, password: String) throws {
        guard let server = serverField.text else {
            return
        }
        
        actionButton.isEnabled = false
        let api = try Api(config: Api.Config(serverUrl: server))
        try api.auth(email: email, password: password).then { (login) in
            try api.info().then({ info in
                guard !info.url.isEmpty else {
                    self.actionButton.isEnabled = true
                    Dialog.show(error: Lang.get("login.info_server_url_empty_error_message"), on: self)
                    return
                }
                let account = try Account.new()
                account.name = info.name
                account.server = info.url
                account.token = login.token
                
                DispatchQueue.main.async {
                    try? account.save()
                    self.account = account
                    self.requestedNextStep?(account)
                }
            }).error({ error in
                self.fail(error: error)
            })
        }
    }
    
    private func fail(error: Error) {
        DispatchQueue.main.async {
            self.actionButton.isEnabled = true
            Dialog.show(error: error, on: self)
        }
    }
    
}
