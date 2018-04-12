//
//  ServerNameViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class ServerNameViewController: ViewController {
    
    var didChangeNameSuccessfully: ((_ account: Account) -> Void)?
    
    let account: Account
    
    let serverField = TextField()
    let saveButton = PrimaryButton()
    
    
    // MARK: Initialization
    
    init(_ account: Account) {
        self.account = account
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
        
        serverField.placeholder = Lang.get("server.name.placeholder")
        serverField.text = account.name
        serverField.validate.serverName()
        serverField.place.on(view, top: 84).sideMargins()
        
        saveButton.setTitle(Lang.get("login.step1.login"), for: .normal)
        saveButton.addTarget(self, action: #selector(didTapSave(_:)), for: .touchUpInside)
        saveButton.place.below(serverField, top: 22).centerX()
    }
    
    // MARK: Actions
    
    @objc func didTapSave(_ sender: UIButton) {
        do {
            account.name = serverField.text
            try account.save()
            didChangeNameSuccessfully?(account)
        } catch {
            // QUESTION: Display dialog? Is this going to happen?
            print(error)
        }
    }
    
}
