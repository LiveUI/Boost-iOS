//
//  AppCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class AppCell: GridCollectionViewCell {
    
    let label = UILabel()
    
    override func setupElements() {
        super.setupElements()
        
        label.textAlignment = .center
        label.textColor = .red
        gridView.add(subview: label)
    }
    
}
