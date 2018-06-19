//
//  AccountsCoordinator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


/// Accounts list coordinator
final class AccountsCoordinator: Coordinator {
    
    /// Current view controller
    var currentViewController: UIViewController?
    
    /// Launch coordinator on a view controller
    @discardableResult func takeOff(in: CoordinatorTakeOffTuple?) -> UIViewController {
        let c = AccountsListViewController()
        currentViewController = c
        return c.asNavigationViewController()
    }
    
}
