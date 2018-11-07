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
    
    /// Current view controller
    var currentViewController: UIViewController?
    
    /// Account
    let account: Account
    
    /// Launch coordinator on a view controller
    @discardableResult func takeOff(in vc: CoordinatorTakeOffTuple?) -> UIViewController {
        let c = AccountViewController(account)
        currentViewController = c
        let nc = c.asNavigationViewController()
        if let vc = vc {
            vc.viewController.present(nc, presentation: vc.presentation)
        }
        return nc
    }
    
    /// Initialization
    init(_ account: Account) {
        self.account = account
    }
    
}
