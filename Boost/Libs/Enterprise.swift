//
//  Enterprise.swift
//  Boost
//
//  Created by Ondrej Rafaj on 05/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Reloaded


class Enterprise {
    
    static func updateServers() throws {
        guard let enterprise = try EnterpriseSettings.load() else {
            return
        }
        for eAccount in enterprise.accounts {
            if let acc = try Account.query.filter("server" == eAccount.server, "enterprise" == true).first() {
                acc.update(from: eAccount)
            } else {
                try eAccount.account()
            }
        }
    }
    
}
