//
//  DisplayModeView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 29/10/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Base
import Modular


class DisplayModeView: View {
    
    private let gridButton = UIButton()
    private let listButton = UIButton()
    
    override func setupElements() {
        super.setupElements()
        
        gridButton.backgroundColor = .red
        gridButton.place.on(self).make.square(side: 36).and.min(bottom: 20)
        
        gridButton.backgroundColor = .blue
        listButton.place.next(to: gridButton, left: 20).match(dimensions: gridButton).match(top: gridButton).min(right: 0).and.right(0)
    }
    
}
