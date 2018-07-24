//
//  GridView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 11/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Hagrid


class GridView: Hagrid.GridView {
    
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
