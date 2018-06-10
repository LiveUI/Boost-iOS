//
//  Account+Enterprise.swift
//  Boost
//
//  Created by Ondrej Rafaj on 05/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Account {
    
    func update(from account: EnterpriseSettings.Account) {
        name = account.name
        server = account.server
        locked = !account.deletable
    }
    
}
