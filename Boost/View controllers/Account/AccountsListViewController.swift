//
//  AccountsListViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import Reloaded
import MarcoPolo


final class AccountsListViewController: TableViewController {
    
    /// Setup data
    override func setupData() {
        super.setupData()
        
        let section = PresentableSection()
        do {
            let accounts = try Account.query.sort(by: "name").all()
            section.set(accounts.map({ (account) -> AnyPresentable in
                Presentable<AccountTableViewCell>.create({ cell in
                    cell.nameLabel.text = account.name
                    cell.hostLabel.text = account.server
                    cell.lockIcon.isHidden = !(account.token?.isEmpty ?? true)
                    cell.onlineIcon.state = account.onlineIsValid ? .online : .offline
                    
//                    let hidden = !(account == self.baseCoordinator.currentAccount)
//                    cell.selectedIndicator.isHidden = hidden
                })
            }))
        } catch {
            
        }
        data.append(section)
    }
    
    // MARK: Elements
    
    override func setupElements() {
        super.setupElements()
        
        navigationViewController?.navigationBar.minHeight = 60
        navigationViewController?.navigationBar.backgroundColor = .red
        navigation.content.title = "Boost"
        navigation.content.subtitle = "server management"
        
        let v = UIView()
        v.backgroundColor = .red
        navigationItem.titleView = v
        
        setupData()
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (try? Account.count()) == 0 {
            baseCoordinator.noAccountPresent(reportedBy: self)
        }
    }
    
}
