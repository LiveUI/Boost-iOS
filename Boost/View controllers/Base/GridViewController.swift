//
//  GridViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Hagrid
import Base


class GridViewController: Hagrid.GridScrollViewController {
    
    /// Background view element
    var backgroundView: UIView?
    
    /// Set coloured background view
    func setupColouredBackgroundView() {
        let backgroundView = BackgroundView(GradientView.Config.basic())
        gridView.insertSubview(backgroundView, at: 0)
        self.backgroundView = backgroundView
        backgroundView.place.on(andFill: gridView)
        gridView.sendSubview(toBack: backgroundView)
    }
    
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
