//
//  GridTableViewCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Hagrid


class GridTableViewCell: Hagrid.GridTableViewCell {
    
    
    /// Setup all on-view elements
    open func setupElements() {
        
    }
    
    /// Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        gridView.config.padding = Padding.horizontal(left: 12, right: 12)
        
        setupElements()
    }
    
}
