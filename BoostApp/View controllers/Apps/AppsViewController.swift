//
//  AppsViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 30/11/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import Modular
import AwesomeEnum
import BoostSDK


class AppsViewController: RootViewController {
    
    // MARK: Initialization
    
    init(leadingApp: App) {
        let manager = AppsDataManager(leadingApp: leadingApp)
        super.init(manager: manager)
        
        title = leadingApp.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
    }
    
}
