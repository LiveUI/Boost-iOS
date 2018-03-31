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


class LeftMenuViewController: UITableViewController {
    
    let manager: LeftMenuDataManager = LeftMenuDataManager()
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.isEditing = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEdit(_:)))
        navigationItem.rightBarButtonItem = edit
        
        var m = manager as PresentableManager
        tableView.bind(withPresentableManager: &m)
    }
    
    // MARK: Actions
    
    @objc func toggleEdit(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
    
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
