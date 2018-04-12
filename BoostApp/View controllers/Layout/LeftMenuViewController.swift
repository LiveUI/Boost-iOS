//
//  LeftMenuViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import SideMenu
import Presentables
import AwesomeEnum
import Modular


class LeftMenuViewController: ViewController {
    
    let accounts = AccountsViewController()
    
    let scrollView = UIScrollView()
    
    // MARK: Settings
    
    func reloadData() {
        accounts.manager.reloadAccounts()
        accounts.setupEditButton()
    }
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
        
        scrollView.place.on(andFill: view)
        
        // Accounts
        addChildViewController(accounts)
        accounts.view.place.on(view, top: 0, bottom: 0).leftMargin(0).match(width: scrollView)
        accounts.didMove(toParentViewController: self)
    }
    
}

// MARK: - Left menu Base view controller

class LeftBaseViewController: UISideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
