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
    
    var refreshControl = UIRefreshControl()
    
    /// Setup data
    override func setupData() {
        super.setupData()
        
        do {
            let otherName = "accounts.group.other"
            var accountGroups: [String: [Account]] = [:]
            try Account.query.sort(by: "name").all().forEach({ account in
                accountGroups[account.group?.name ?? otherName, default: []].append(account)
            })
            // Sort keys
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
                    // Skip other title if it's the only section in the table
                    if accountGroupsKeys.count > 1 {
                        section.header = Presentable<GenericTableHeaderView>.create({ header in
                            header.title.text = Lang.get(key).uppercased()
                        })
                    }
                    // Make section cells
                    section.set(group.map({ (account) -> AnyPresentable in
                        Presentable<AccountTableViewCell>.create({ cell in
                            cell.nameLabel.text = account.name
                            cell.hostLabel.text = account.server
                            cell.lockIcon.isHidden = !(account.token?.isEmpty ?? true)
                            cell.onlineIcon.state = account.onlineIsValid ? .online : .offline
                        }).cellSelected {
                            try? self.baseCoordinator.request(detailFor: account)
                        }
                    }))
                    data.append(section)
                }
            }
        } catch {
            
        }
    }
    
    // MARK: Elements
    
    private func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: Lang.get("general.pull-to-refresh"))
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func setupElements() {
        super.setupElements()
        
        tableView.separatorStyle = .none
        
        navigation.navigationController?.navigationBar.minHeight = 60
        navigation.content.title = Lang.get("accounts.navigation.title")
        navigation.content.subtitle = Lang.get("accounts.navigation.subtitle")
        
        navigation.set(leftItem: UIImage(named: "navbar/menu-settings")?.asButton(self, action: #selector(settingsTapped(_:))))
        navigation.set(rightItem: UIImage(named: "navbar/menu-add")?.asButton(self, action: #selector(addTapped(_:))))
        
        setupPullToRefresh()
    }
    
    // MARK: Actions
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
    }
    
    @objc func settingsTapped(_ sender: UIButton) {
        
    }
    
    @objc func addTapped(_ sender: UIButton) {
        
    }
    
    // MARK: View lifecycle
    
    var firstStart: Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if firstStart {
            do {
                if let account = try Account.lastUsed() {
                    try baseCoordinator.request(detailFor: account)
                }
            } catch {
                // TODO: Handle error?!
            }
            firstStart = false
        }
        
        // Refresh online status of all accounts
        try? Account.refreshOnlineStatus { account in
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (try? Account.count()) == 0 {
            baseCoordinator.noAccountPresent(reportedBy: self)
        }
    }
    
}
