//
//  UIViewController+Navigation.swift
//  LiveUIBase
//
//  Created by Ondrej Rafaj on 28/05/2018.
//

@_exported import Foundation
@_exported import UIKit
import Base


extension UIViewController {
    
    /// Return view controller as a root of a new UINavigationController
    public func asNavigationViewController() -> NavigationViewController {
        let nc = NavigationViewController(rootViewController: self)
        return nc
    }
    
    /// Has UIViewController been presented modally?
    public func isModal() -> Bool {
        if self.presentingViewController != nil ||
            self.navigationController?.presentingViewController?.presentedViewController == self.navigationController ||
            self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
    
    /// Present view controller
    public func present(_ viewController: UIViewController, presentation: Presentation) {
        presentation.setModalAttributes(on: viewController)
        
        switch presentation {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
        default:
            present(viewController, animated: presentation.animated)
        }
    }
    
    /// Close view controller
    public func close(animated: Bool = true) {
        if isModal() {
            dismiss(animated: animated)
        } else {
            navigationController?.popViewController(animated: animated)
        }
    }
    
}
