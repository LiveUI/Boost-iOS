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
        
        do {
            let otherName = "accounts.group.other"
            var accountGroups: [String: [Account]] = [:]
            try Account.query.sort(by: "name").all().forEach({ account in
                accountGroups[account.group?.name ?? otherName, default: []].append(account)
            })
            let accountGroupsKeys = accountGroups.keys.sorted(by: { (s1, s2) -> Bool in
                if s1 == otherName {
                    return false
                } else if s2 == otherName {
                    return true
                } else {
                    return s1 < s2
                }
            })
            for key in accountGroupsKeys {
                if let group: [Account] = accountGroups[key] {
                    let section = PresentableSection()
                    section.header = Presentable<GenerictTableHeaderView>.create({ header in
                        header.title.text = Lang.get(key).uppercased()
                    })
                    section.set(group.map({ (account) -> AnyPresentable in
                        Presentable<AccountTableViewCell>.create({ cell in
                            cell.nameLabel.text = account.name
                            cell.hostLabel.text = account.server
                            cell.lockIcon.isHidden = !(account.token?.isEmpty ?? true)
                            cell.onlineIcon.state = account.onlineIsValid ? .online : .offline
                        })
                    }))
                    data.append(section)
                }
            }
        } catch {
            
        }
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
