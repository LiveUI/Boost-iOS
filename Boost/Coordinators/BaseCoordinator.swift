//
//  BaseCoordinator.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


/// Main coordinator for the whole app
/// This coordinator should be only starting new coordinators and shouldn't push any screens directly
final class BaseCoordinator {
    
    /// Root view controller for the whole app
    let rootViewController = UIViewController()
    
    /// Display the screen that has been last used or server list or login
    /// This method is used on initialization
    func showInitialScreen() {
        
    }
    
}
