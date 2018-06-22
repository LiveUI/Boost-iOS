//
//  AppLoadingCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 20/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
    
    
class AppLoadingCell: GridCollectionViewCell {
    
    override func setupElements() {
        super.setupElements()
        
        gridView.backgroundColor = .purple
        
        gridView.config.displayGrid = true
    }
    
}
