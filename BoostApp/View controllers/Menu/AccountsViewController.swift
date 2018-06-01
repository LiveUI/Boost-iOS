//
//  AccountsViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import AwesomeEnum


class AccountsViewController: MenuViewController {
    
    let manager: AccountsDataManager = AccountsDataManager()
    
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            try manager.loadOnlineStatus()
        } catch {
            print(error)
            // QUESTION: Do we want to do anything here?
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Top bar elements
        let title = MenuTitleLabel(Lang.get("menu.accounts.title"))
        title.place.on(topBar).center().sideToSide()
        
        let aboutButton = UIButton()
        aboutButton.setImage(Awesome.solid.question.navBarIcon(.white), for: .normal)
        aboutButton.sizeToFit()
        aboutButton.addTarget(self, action: #selector(didTapInfoButton(_:)), for: .touchUpInside)
        aboutButton.place.on(topBar).leftMargin(10).centerY()
        
        // Table view handling
        var m = manager as PresentableManager
        tableView.bind(withPresentableManager: &m)
        
        manager.accountHasBeenDeleted = {
            if self.manager.accounts.count == 0 {
                self.tableView.isEditing = false
                self.baseCoordinator.noMoreAccountsAvailable()
            }
        }
    }
    
    // MARK: Actions
    
    @objc func didTapInfoButton(_: UIButton) {
        baseCoordinator.navigate(to: .about)
    }
    
}
