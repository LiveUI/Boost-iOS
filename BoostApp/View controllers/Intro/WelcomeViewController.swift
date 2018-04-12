//
//  WelcomeViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular


class WelcomeViewController: ViewController {
    
    let label = UILabel()
    let newAccountButton = PrimaryButton()
    
    // MARK: Configire elements
    
    override func configureElements() {
        super.configureElements()
        
        label.text = Lang.get("welcome.intro_text")
        label.textAlignment = .center
        label.place.on(view).centerY().sideMargins(left: 20, right: -20)
        
        newAccountButton.setTitle(Lang.get("welcome.login_button_title"), for: .normal)
        newAccountButton.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        newAccountButton.place.below(label, top: 40).centerX()
    }
    
    // MARK: Actions
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        appDelegate.coordinator.navigate(to: .newAccount(success: nil))
    }
    
}
