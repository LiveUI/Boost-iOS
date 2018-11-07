//
//  LoginCoordinator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


/// Login process coordinator
final class LoginCoordinator: Coordinator {
    
    /// Current view controller
    var currentViewController: UIViewController?
    
    /// Login route
    enum Route {
        
        /// First use
        case firstUse
        
        /// Re-login to an already added server
        case reLogin
        
        /// Register
        case register
        
    }
    
    /// Selected route
    let selectedRoute: Route
    
    /// Launch coordinator on a view controller
    @discardableResult func takeOff(in: CoordinatorTakeOffTuple? = nil) -> UIViewController {
        if selectedRoute == .firstUse {
            let onboarding = self.onboarding()
            configure(onboarding: onboarding) { sender in
//                let register = RegisterViewController()
//                register.modalTransitionStyle = .crossDissolve
//                onboarding.present(register, animated: true)
                onboarding.dismiss(animated: true)
            }
            return onboarding
        } else {
            fatalError()
        }
    }
    
    /// Initialization
    init(route: Route) {
        selectedRoute = route
    }
    
    // MARK: Private interface
    
    private func startFirstUse() {
        
    }
    
    private func login(to server: Account) {
        
    }
    
}
