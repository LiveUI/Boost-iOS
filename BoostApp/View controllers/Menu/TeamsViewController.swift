//
//  TeamsViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables


class TeamsViewController: MenuViewController {
    
    let manager = TeamsDataManager()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var m = manager as PresentableManager
        tableView.bind(withPresentableManager: &m)
    }
    
}
