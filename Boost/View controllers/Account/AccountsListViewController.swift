//
//  AccountsListViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Reloaded
import Presentables


final class AccountsListViewController: TableViewController {
    
    /// Setup data
    override func setupData() {
        super.setupData()
        
        let section = PresentableSection()
        do {
            section.set(try Account.query.sort(by: "name").all().map({ (account) -> AnyPresentable in
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
    }
    
}
