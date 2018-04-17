//
//  LoginCoordinator.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 28/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class LoginCoordinator {
    
    typealias AccountClosure = ((_ account: Account) -> Void)
    
    var accountHasBeenCreated: AccountClosure?
    var accountHasBeenModified: AccountClosure?
    
    var baseCoordinator: BaseCoordinator {
        return (UIApplication.shared.delegate as! AppDelegate).coordinator
    }
    
    
    // MARK: Navigation
    
    func presentLogin(success: AccountClosure?) {
        let c = LoginViewController(mode: .newAccount)
        c.requestedNextStep = { account in
            self.accountHasBeenCreated?(account)
            let nameControntroller = ServerNameViewController(account)
            nameControntroller.didChangeNameSuccessfully = { account in
                c.dismiss(animated: true, completion: {
                    self.accountHasBeenModified?(account)
                    self.baseCoordinator.navigate(to: .home(account, .all))
                })
            }
            c.navigationController?.pushViewController(nameControntroller, animated: true)
        }
        let nc = UINavigationController(rootViewController: c)
        baseCoordinator.present(viewController: nc)
    }
    
    func presentLogin(for account: Account, success: @escaping AccountClosure) {
        let c = LoginViewController(mode: .login)
        c.account = account
        c.requestedNextStep = success
        let nc = UINavigationController(rootViewController: c)
        baseCoordinator.present(viewController: nc)
    }
    
}
