//
//  AccountsViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import AwesomeEnum


class AccountsViewController: UITableViewController {
    
    let manager: AccountsMenuDataManager = AccountsMenuDataManager()
    
    
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
        
        manager.accountHasBeenDeleted = {
            self.setupEditButton()
            
            if self.manager.accounts.count == 0 {
                self.tableView.isEditing = false
                self.appDelegate.coordinator.noMoreAccountsAvailable()
            }
        }
        
        tableView.removeEmptyRows()
    }
    
    func setupEditButton() {
        if manager.accounts.count > 0 {
            let icon = (tableView.isEditing ? Awesome.solid.check : Awesome.solid.edit).navBarIcon()
            let edit = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(toggleEdit(_:)))
            navigationItem.setRightBarButton(edit, animated: true)
        } else {
            navigationItem.setRightBarButton(nil, animated: true)
        }
    }
    
    // MARK: Actions
    
    @objc func toggleEdit(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        setupEditButton()
    }
    
}
