//
//  AccountsListDataManager.swift
//  Boost
//
//  Created by Ondrej Rafaj on 20/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK


class AccountDataManager: PresentableCollectionViewDataManager {
    
    /// Account
    let account: Account
    
    /// Api
    let api: Api
    
    /// Initializer
    init(_ account: Account) {
        self.account = account
        api = account.api()
        
        super.init()
        
        loadPreloadData()
    }
    
    /// Load apps
    func getApps() {
        do {
            try api.apps().then({ apps in
                self.makePresentables(apps)
            }).error({ error in
                self.baseCoordinator.requestAccountsList()
            })
        } catch {
            
        }
    }
    
    // MARK: Private interface
        
    /// MAke presentables from apps
    private func makePresentables(_ apps: [App]) {
        print(apps)
    }
    
}
