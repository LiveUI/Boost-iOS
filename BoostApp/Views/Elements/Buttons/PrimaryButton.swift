//
//  PrimaryButton.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import MaterialComponents.MDCRaisedButton


class PrimaryButton: MDCRaisedButton {
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        
        sizeToFit()
    }
    
}
