//
//  GridScrollView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 31/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Hagrid


class GridScrollView: Hagrid.GridScrollView {
    
    /// Setup all on-view elements
    open func setupElements() {
        
    }
    
    /// Initialization
    public init() {
        super.init(frame: CGRect.zero)
        
        setupElements()
    }
    
    /// Not implemented
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
