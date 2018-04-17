//
//  NSObject+AppDelegateTools.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import BoostSDK


extension NSObject {
    
    var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return delegate
    }
    
    var api: Api? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return delegate.coordinator.currentApi
    }
    
    var baseCoordinator: BaseCoordinator {
        return appDelegate.coordinator
    }
    
    var loginCoordinator: LoginCoordinator {
        return appDelegate.coordinator.loginCoordinator
    }
    
    var appFlowCoordinator: AppFlowCoordinator {
        return appDelegate.coordinator.appFlowCoordinator
    }
    
    var device: Device {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return .phone
        case .pad:
            return .tablet
        case .tv:
            return .tv
        default:
            return .phone
        }
    }
    
}
