//
//  BaseCoordinator.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import SideMenu
import AwesomeEnum


class BaseCoordinator {
    
    enum Location {
        case home
        case settings
    }
    
    let leftScreen: LeftMenuViewController
    var currentScreen: UIViewController = HomeViewController()
    
    let leftBaseScreen: LeftBaseViewController
    let centerBaseScreen: CenterViewController
    
    // MARK: Initialization
    
    init() {
        leftScreen = LeftMenuViewController()
        leftBaseScreen = LeftBaseViewController(rootViewController: leftScreen)
        SideMenuManager.default.menuLeftNavigationController = leftBaseScreen

        centerBaseScreen = CenterViewController()
        centerBaseScreen.reportViewDidLoad = {
            
        }
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: centerBaseScreen.view, forMenu: .left)
        
        present(viewController: currentScreen)
    }
    
    // MARK: Settings
    
    func refresh(menuWidth width: CGFloat) {
        let w = (width - 44)
        let cw = ((w < 278) ? 278 : w)
        let menuWidth: CGFloat = (cw > 320) ? 320 : cw
        SideMenuManager.default.menuWidth = menuWidth
    }
    
    // MARK: Navigation
    
    func navigate(to: Location) {
        switch to {
        case .settings:
            present(viewController: SettingsViewController())
        default:
            present(viewController: HomeViewController())
        }
    }
    
    private func present(viewController: UIViewController) {
        if let nc = currentScreen as? UINavigationController, let v = nc.viewControllers.first, v >!< viewController {
            centerBaseScreen.dismiss(animated: true, completion: nil)
            return
        }
        
        let nc = UINavigationController(rootViewController: viewController)
        
        let menu = UIBarButtonItem(image: Awesome.solid.list.asImage(size: 22), style: UIBarButtonItemStyle.done, target: self, action: #selector(didTapMenu(_:)))
        viewController.navigationItem.leftBarButtonItem = menu
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: nc.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: nc.view, forMenu: .left)
        
        if currentScreen.view.superview != nil {
            currentScreen.view.removeFromSuperview()
            currentScreen.removeFromParentViewController()
        }
        if currentScreen.parent != nil {
            
        }
        
        centerBaseScreen.addChildViewController(nc)
        nc.view.frame = centerBaseScreen.view.bounds
        centerBaseScreen.view.addSubview(nc.view)
        nc.didMove(toParentViewController: centerBaseScreen)

        currentScreen = nc
        
        centerBaseScreen.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapMenu(_ sender: UIBarButtonItem) {
        centerBaseScreen.present(leftBaseScreen, animated: true, completion: nil)
    }
    
}
