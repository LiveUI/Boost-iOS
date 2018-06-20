//
//  GridCollectionReusableView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 20/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Hagrid


class GridCollectionReusableView: Hagrid.GridCollectionReusableView {
    
    /// Setup all on-view elements
    open func setupElements() {
        
    }
    
    /// Initialization
    override public init(frame rect: CGRect) {
        super.init(frame: rect)
        
        setupElements()
    }

}
