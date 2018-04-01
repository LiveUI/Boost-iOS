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
        
        setupEditButton()
        
        var m = manager as PresentableManager
        tableView.bind(withPresentableManager: &m)
    }
    
    func setupEditButton() {
        let edit = UIBarButtonItem(barButtonSystemItem: tableView.isEditing ? .done : .edit, target: self, action: #selector(toggleEdit(_:)))
        navigationItem.setRightBarButton(edit, animated: true)
    }
    
    // MARK: Actions
    
    @objc func toggleEdit(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        setupEditButton()
    }
    
}

// MARK: - Left menu Base view controller

class LeftBaseViewController: UISideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
