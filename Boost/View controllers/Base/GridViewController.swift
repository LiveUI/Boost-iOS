//
//  GridViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Hagrid


class GridViewController: Hagrid.GridScrollViewController {
    
    /// Setup all on-screen elements
    open func setupElements() {
        gridView.config.padding = Padding.horizontal(left: 26, right: 26)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
    }
    
}
