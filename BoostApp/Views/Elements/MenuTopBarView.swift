//
//  MenuTopBarView.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialColorScheme


class MenuTopBarView: UIView {
    
    
    // MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = MDCPalette.lightBlue.tint800
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
