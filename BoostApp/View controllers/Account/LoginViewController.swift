//
//  LoginViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import Modular
import Reloaded
import BoostSDK


class LoginViewController: ViewController {
    
    var didLoginSuccessfully: ((_ account: Account) -> Void)?
    
    let serverField = MDCTextField()
    let loginField = MDCTextField()
    let passwordField = MDCTextField()
    let loginButton = MDCButton()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let close = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose(_:)))
        navigationItem.leftBarButtonItem = close
        
        serverField.placeholder = "https://api.boost-appstore.com"
        serverField.text = "http://localhost:8080"
        serverField.place.on(view, height: 44, top: 70).sideMargins(left: 20, right: -20)
        
        loginField.placeholder = "email@example.com"
        loginField.text = "admin@liveui.io"
        loginField.place.below(serverField, top: 12).match(height: serverField).match(left: serverField).match(right: serverField)
        
        passwordField.placeholder = "sup3rS3cr3t"
        passwordField.text = "admin"
        passwordField.isSecureTextEntry = true
        passwordField.place.below(loginField, top: 12).match(height: serverField).match(left: serverField).match(right: serverField)
        
        loginButton.setTitle(Lang.get("Login"), for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLogin(_:)), for: .touchUpInside)
        loginButton.place.below(passwordField, top: 12).match(height: serverField).match(left: serverField).match(right: serverField)
    }
    
    // MARK: Actions
    
    @objc func didTapClose(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapLogin(_ sender: UIButton) {
        guard let server = serverField.text, let email = loginField.text, let password = passwordField.text else {
            return
        }
        
        do {
            let api = try Api(config: Api.Config(serverUrl: server))
            try api.auth(email: email, password: password).then { (login) in
                let acc = try Account.new()
                acc.server = self.serverField.text
                acc.name = "Account name fetched from the server"
                acc.token = login.token
                try acc.save()
                
                self.didLoginSuccessfully?(acc)
                
                self.dismiss(animated: true)
            }
        } catch {
            // TODO: handle error
        }
    }
    
}
