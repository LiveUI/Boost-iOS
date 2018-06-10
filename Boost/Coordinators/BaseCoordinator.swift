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
    
    /// Current coordinator
    var currentCoordinator: Coordinator?
    
    /// Side of the app
    enum Side {
        
        /// Accounts
        case accounts
        
        /// Home
        case home
        
    }
    
    /// Current side
    var currentSide: Side {
        return (appDelegate.rootViewController is AccountsListViewController) ? .accounts : .home
    }
    
    /// Display the screen that has been last used or server list or login
    /// This method is used on initialization
    func initialScreen() -> UIViewController {
        try? Enterprise.updateServers()
        
        let coordinator: Coordinator
        do {
            if let account = try Account.lastUsed() { // If an account has been used before
                coordinator = AccountCoordinator(account)
            } else {
                coordinator = AccountsCoordinator()
            }
        } catch {
            let message = ErrorViewController.Message(title: Lang.get("general.system_error"), message: Lang.get("data.error.corrupted"), close: Lang.get("general.kill_all"))
            let errorController = ErrorViewController(message)
            errorController.shouldClose = { controller in
                fatalError(error.localizedDescription)
            }
            return errorController
        }
        currentCoordinator = coordinator
        return coordinator.takeOff(in: nil)
    }
    
    /// No account present
    func noAccountPresent(reportedBy viewController: ViewController) {
        let loginCoordinator = LoginCoordinator(route: .firstUse)
        let c = loginCoordinator.takeOff()
        viewController.present(c, animated: true)
    }
    
}
