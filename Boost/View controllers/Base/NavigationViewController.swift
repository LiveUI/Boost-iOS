//
//  NavigationViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import MarcoPolo
import Base


public final class NavigationViewController: MarcoPolo.NavigationViewController {
    
    // MARK: View lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleView?.titleLabel.font = Font.bold(size: 14)
        navigationBar.titleView?.subtitleLabel.font = Font.light(size: 12)
    }
    
}
