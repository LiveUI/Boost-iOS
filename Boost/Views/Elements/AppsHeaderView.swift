//
//  AppsHeaderView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 29/10/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Base
import Modular


class AppsHeaderView: CollectionReusableView {
    
    let displayModeView = DisplayModeView()
    
    override func setupElements() {
        super.setupElements()
        
        backgroundColor = .orange
        
        displayModeView.place.on(self)
    }
    
}
