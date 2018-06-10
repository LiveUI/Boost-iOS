//
//  AppDelegate+Tools.swift
//  Boost
//
//  Created by Ondrej Rafaj on 28/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension AppDelegate {
    
    /// Root view controller
    var rootViewController: UIViewController? {
        return rootNavigationViewController?.viewControllers.first
    }
    
    /// Root navigation view controller
    var rootNavigationViewController: UINavigationController? {
        return window?.rootViewController as? UINavigationController
    }
    
    /// Get instance of AppDelegate
    static var get: AppDelegate {
        return UIApplication.shared.appDelegate
    }
    
}
