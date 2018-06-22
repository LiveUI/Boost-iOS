//
//  BaseCoordinator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


/// Main coordinator for the whole app
/// This coordinator should be only starting new coordinators and shouldn't push any screens directly
final class BaseCoordinator: NSObject {
    
    var rootViewController: UIViewController!
    
    /// Current coordinator
    var currentCoordinator: Coordinator?
    
//    /// Side of the app
//    enum Side {
//
//        /// Accounts
//        case accounts
//
//        /// Home
//        case home
//
//    }
//
//    /// Current side
//    var currentSide: Side!
    
    /// Display the screen that has been last used or server list or login
    /// This method is used on initialization
    func initialScreen() -> UIViewController {
        try? Enterprise.updateServers()
        
        let coordinator = AccountsCoordinator()
        
//        let coordinator: Coordinator
//        do {
//            if let account = try Account.lastUsed() { // If an account has been used before
//                coordinator = AccountCoordinator(account)
//            } else {
//                coordinator = AccountsCoordinator()
//            }
//        } catch {
//            let message = ErrorViewController.Message(title: Lang.get("general.system_error"), message: Lang.get("data.error.corrupted"), close: Lang.get("general.kill_all"))
//            let errorController = ErrorViewController(message)
//            // TODO: Track error!
//            errorController.shouldClose = { controller in
//                fatalError(error.localizedDescription)
//            }
//            return errorController
//        }
        currentCoordinator = coordinator
        rootViewController = coordinator.takeOff(in: nil)
        return rootViewController
    }
    
    /// No account present
    func noAccountPresent(reportedBy viewController: ViewController) {
        let loginCoordinator = LoginCoordinator(route: .firstUse)
        let c = loginCoordinator.takeOff()
        viewController.present(c, animated: true)
    }
    
    /// Account details requested
    func request(detailFor account: Account) throws {
        account.lastUsed = Date()
        try account.save()
        
        let coordinator = AccountCoordinator(account)
        flip(to: coordinator)
    }
    
    /// Account list requested
    func requestAccountsList() {
        let coordinator = AccountsCoordinator()
        flip(to: coordinator)
    }
    
    /// Authentication to account failed first time
    func authFailed(forAccount account: Account, in viewController: AccountViewController) {
        let login = LoginViewController({ (email, password) in
            do {
                try viewController.manager.api.auth(email: email, password: password).then({ login in
                    account.token = login.token
                    account.lastSeen = Date()
                    account.lastUsed = Date()
                    DispatchQueue.main.async {
                        try? account.save()
                        viewController.dismiss(animated: true, completion: {
                            viewController.reloadData()
                        })
                    }
                }).error({ error in
                    // TODO: Display error in login!!!!
                })
            } catch {
                self.somethingFailed(forAccount: account, in: viewController)
            }
        }, close: {
            self.somethingFailed(forAccount: account, in: viewController)
        })
        viewController.present(login.asNavigationViewController(), presentation: Presentation.presentForm)
    }
    
    /// Authentication to account failed first time
    func somethingFailed(forAccount account: Account, in viewController: AccountViewController) {
        // TODO: Display error message!!!
        requestAccountsList()
    }
    
    // MARK: Private interface
    
    func flip(to coordinator: Coordinator) {
        currentCoordinator = coordinator
        if coordinator is AccountsCoordinator {
            rootViewController.dismiss(animated: true)
        } else {
            coordinator.takeOff(in: (rootViewController, .flip))
        }
    }
    
}
