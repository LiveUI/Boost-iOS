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
import Modular


class LeftMenuViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = UIButton()
        home.setTitle(Lang.get("Home"), for: .normal)
        home.setTitleColor(.white, for: .normal)
        home.addTarget(self, action: #selector(didTapHome(_:)), for: .touchUpInside)
        home.backgroundColor = .gray
        home.place.onTopLeft(of: view, height: 44, top: 94, left: 20).with.rightMargin(-20)
        
        let settings = UIButton()
        settings.setTitle(Lang.get("Settings"), for: .normal)
        settings.setTitleColor(.white, for: .normal)
        settings.addTarget(self, action: #selector(didTapSettings(_:)), for: .touchUpInside)
        settings.backgroundColor = .gray
        settings.place.below(home, top: 12).match(left: home).match(right: home).match(height: home)
    }
    
    // MARK: Actions
    
    @objc func didTapHome(_ sender: UIButton) {
        appDelegate.coordinator.navigate(to: .home)
    }
    
    @objc func didTapSettings(_ sender: UIButton) {
        appDelegate.coordinator.navigate(to: .settings)
    }
    
}

// MARK: - Left menu Base view controller

class LeftBaseViewController: UISideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
