//
//  AccountsDataManager.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 31/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import AwesomeEnum


class AccountsDataManager: PresentableTableViewDataManager {
    
    var accountHasBeenDeleted: (() -> Void)?
    
    var accounts: [Account] = []
    
    private let accountsSection = PresentableSection()
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        reloadAccounts()
        
        data.append(accountsSection)
        
        let settingsSection = PresentableSection()
        let setting = Presentable<TeamsTableViewCell>.create({ cell in
            cell.titleLabel.text = Lang.get("menu.accounts.settings")
            cell.icon.set(image: Awesome.solid.cogs.cellIcon())
        }).cellSelected {
            self.appDelegate.coordinator.navigate(to: .settings)
        }
        settingsSection.presentables.append(setting)
        data.append(settingsSection)
        
        
        selectedCell = { info in
            info.tableView.deselectRow(at: info.indexPath, animated: true)
        }
    }
    
    // MARK: Data
    
    func loadOnlineStatus() throws {
        var i = 0
        for account in accounts {
            let indexPath = IndexPath(row: i, section: 0)
            try account.api().ping().then { pong in
                DispatchQueue.main.async {
                    account.online = true
                    account.lastSeen = Date()
                    try? account.save()
                    self.reload(indexPath: indexPath)
                }}.error { error in
                    DispatchQueue.main.async {
                        account.online = false
                        try? account.save()
                        self.reload(indexPath: indexPath)
                    }
            }
            i += 1
        }
    }
    
    func reloadAccounts() {
        accountsSection.presentables.removeAll()
        do {
            accounts = try Account.all()
            for account in accounts {
                let acc = Presentable<AccountTableViewCell>.create({ (cell) in
                    cell.nameLabel.text = account.name
                    cell.hostLabel.text = account.server
                    cell.lockIcon.isHidden = !(account.token?.isEmpty ?? true)
                    cell.onlineIcon.state = account.onlineIsValid ? .online : .offline
                    
                    let hidden = !(account == self.appDelegate.coordinator.currentAccount)
                    cell.selectedIndicator.isHidden = hidden
                }).cellSelected {
                    self.appDelegate.coordinator.navigate(to: .home(account))
                }
                accountsSection.presentables.append(acc)
            }
        } catch {
            // TODO: Handle
        }
        
        // New account cell
        let newAccount = Presentable<TeamsTableViewCell>.create({ (cell) in
            cell.titleLabel.text = Lang.get("menu.accounts.new_account")
            cell.icon.set(image: Awesome.solid.plus.cellIcon())
        }).cellSelected {
            self.appDelegate.coordinator.navigate(to: .newAccount(success: { account in
                self.reloadAccounts()
            }))
        }
        accountsSection.presentables.append(newAccount)
    }
    
    // MARK: Table view delegate overrides
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && indexPath.row != accounts.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        accountsSection.presentables.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        
        let acc = accounts[indexPath.row]
        do {
            try acc.delete()
        } catch {
            // TODO: Handle
        }
        
        accounts.remove(at: indexPath.row)
        
        accountHasBeenDeleted?()
    }
    
}
