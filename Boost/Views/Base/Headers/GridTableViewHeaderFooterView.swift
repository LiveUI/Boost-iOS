//
//  GridTableViewHeaderFooterView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 11/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Hagrid


class GridTableViewHeaderFooterView: Hagrid.GridTableViewHeaderFooterView {
    
    /// Setup all on-view elements
    open func setupElements() {
        
    }
    
    /// Initialization
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupElements()
    }
    
}
