//
//  AccountCoordinator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


/// Single account coordinator
final class AccountCoordinator: Coordinator {
    
    /// Account
    let account: Account
    
    /// Launch coordinator on a view controller
    @discardableResult func takeOff(in: (UIViewController, Presentation)?) -> UIViewController {
        let c = AccountViewController(account)
        return c.asNavigationViewController()
    }
    
    /// Initialization
    init(_ account: Account) {
        self.account = account
    }
    
}
