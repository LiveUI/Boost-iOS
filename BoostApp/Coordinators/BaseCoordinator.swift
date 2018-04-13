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
import Reloaded


class BaseCoordinator {
    
    enum Location {
        case welcome
        case home(Account)
        case newAccount(success: LoginCoordinator.AccountClosure?)
        case settings
    }
    
    let leftScreen: LeftMenuViewController
    var currentScreen: UIViewController? = UIViewController()
    
    let leftBaseScreen: LeftBaseViewController
    let centerBaseScreen: CenterViewController
    
    var loginCoordinator: LoginCoordinator
    
    // MARK: Initialization
    
    init() {
        leftScreen = LeftMenuViewController()
        leftBaseScreen = LeftBaseViewController(rootViewController: leftScreen)
        SideMenuManager.default.menuLeftNavigationController = leftBaseScreen

        centerBaseScreen = CenterViewController()
        centerBaseScreen.reportViewDidLoad = {
            
        }
        
        loginCoordinator = LoginCoordinator()
        loginCoordinator.accountHasBeenCreated = { account in
            self.leftScreen.reloadData()
        }
        loginCoordinator.accountHasBeenModified = { account in
            self.leftScreen.reloadData()
        }
        
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: centerBaseScreen.view, forMenu: .left)
        
        // Register API bad token notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(accountInvalid(_:)), name: Account.InvalidToken, object: nil)
        
        // Navigate to the last account used
        guard let account = try! Account.query.filter("token" != nil).sort(by: "lastUsed", direction: .orderedDescending).first() else {
            navigate(to: .welcome)
            return
        }
        navigate(to: .home(account))
    }
    
    // MARK: Settings
    
    func refresh(menuWidth width: CGFloat) {
        let w = (width - 44)
        let cw = ((w < 278) ? 278 : w)
        let menuWidth: CGFloat = (cw > 320) ? 320 : cw
        SideMenuManager.default.menuWidth = menuWidth
    }
    
    // MARK: Informators
    
    func noMoreAccountsAvailable() {
        navigate(to: .welcome)
    }
    
    // MARK: Navigation
    
    var currentLocation: Location = .settings
    
    func navigate(to: Location) {
        switch to {
        case .welcome:
            show(viewController: WelcomeViewController())
        case .home(let account):
            if account.token == nil {
                loginCoordinator.presentLogin(for: account) { account in
                    self.navigate(to: .home(account))
                }
            } else {
                account.lastUsed = Date()
                try? account.save() // Save the account that has been opened last
                leftScreen.didLogin(to: account) // Load teams in the lest menu
                show(viewController: OverviewViewController(account: account)) // Show overview
            }
        case .newAccount(let success):
            loginCoordinator.presentLogin(success: success)
        case .settings:
            show(viewController: SettingsViewController())
        }
    }
    
    func present(viewController: UIViewController) {
        let vc: UIViewController = leftBaseScreen.isHidden ? centerBaseScreen : leftBaseScreen
        vc.present(viewController, animated: true)
    }
    
    @objc private func didTapMenu(_ sender: UIBarButtonItem) {
        centerBaseScreen.present(leftBaseScreen, animated: true, completion: nil)
    }
    
    // MARK: Notifications
    
    @objc func accountInvalid(_ sender: NSNotification) {
        leftScreen.reloadData()
        leftScreen.didLogOut()
        
        currentScreen?.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    // MARK: Private interface
    
    func show(viewController: UIViewController) {
        let nc = UINavigationController(rootViewController: viewController)
        
        let menu = UIBarButtonItem(image: Awesome.solid.list.asImage(size: 22), style: UIBarButtonItemStyle.done, target: self, action: #selector(didTapMenu(_:)))
        viewController.navigationItem.leftBarButtonItem = menu
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: nc.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: nc.view, forMenu: .left)
        
        if let currentScreen = currentScreen, currentScreen.view.superview != nil {
            currentScreen.view.removeFromSuperview()
            currentScreen.removeFromParentViewController()
        }
        
        centerBaseScreen.addChildViewController(nc)
        nc.view.frame = centerBaseScreen.view.bounds
        centerBaseScreen.view.addSubview(nc.view)
        nc.didMove(toParentViewController: centerBaseScreen)
        
        currentScreen = nc
        
        centerBaseScreen.dismiss(animated: true, completion: nil)
    }
    
}
