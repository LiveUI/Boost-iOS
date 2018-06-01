//
//  Account+CoreData.swift
//  Boost
//
//  Created by Ondrej Rafaj on 29/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Reloaded
import BoostSDK


extension Account: Entity { }


extension Account {
    
    func api() -> Api {
        guard let server = self.server, let api = try? Api(config: Api.Config(serverUrl: server, token: token)) else {
            fatalError("Account has to have a server url")
        }
        return api
    }
    
}
