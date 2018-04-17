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
import BoostSDK


class BaseCoordinator {
    
    enum Location {
        case welcome
        case about
        case home(Account, ActiveTeam)
        case newAccount(success: LoginCoordinator.AccountClosure?)
        case settings
    }
    
    enum ActiveTeam {
        case all
        case specific(Team)
        
        var team: Team? {
            switch self {
            case .specific(let team):
                return team
            default:
                return nil
            }
        }
        
        var isAll: Bool {
            switch self {
            case .all:
                return true
            default:
                return false
            }
        }
    }
    
    let leftScreen: LeftMenuViewController
    var currentScreen: UIViewController? = UIViewController()
    
    let leftBaseScreen: LeftBaseViewController
    let centerBaseScreen: CenterViewController
    
    var loginCoordinator: LoginCoordinator
    var appFlowCoordinator: AppFlowCoordinator
    
    
    var currentLocation: Location = .settings
    var currentAccount: Account? {
        didSet {
            currentApi = currentAccount?.api()
        }
    }
    var currentApi: Api?
    
    
    // MARK: Initialization
    
    init() {
        leftScreen = LeftMenuViewController()
        leftBaseScreen = LeftBaseViewController(rootViewController: leftScreen)
        
        centerBaseScreen = CenterViewController()
        
        loginCoordinator = LoginCoordinator()
        appFlowCoordinator = AppFlowCoordinator()
    }
    
    private func setup() {
        SideMenuManager.default.menuLeftNavigationController = leftBaseScreen
        SideMenuManager.default.menuAnimationBackgroundColor = Theme.default.menuNavigationColor.hexColor
        
        centerBaseScreen.reportViewDidLoad = {
            
        }
        
        loginCoordinator.accountHasBeenCreated = { account in
            self.leftScreen.reloadData()
        }
        loginCoordinator.accountHasBeenModified = { account in
            self.leftScreen.reloadData()
        }
        
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: centerBaseScreen.view, forMenu: .left)
        
        // Register API bad token notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(accountInvalid(_:)), name: Account.InvalidToken, object: nil)
        
        showInitialScreen()
    }
    
    // MARK: Settings
    
    func refresh(menuWidth width: CGFloat) {
        let screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        let maxWidth = min((screenWidth - 34), 400)
        let w = (width - 44)
        let cw = ((w < 278) ? 278 : w)
        let menuWidth: CGFloat = (cw > maxWidth) ? maxWidth : cw
        SideMenuManager.default.menuWidth = menuWidth
    }
    
    // MARK: Informators
    
    func noMoreAccountsAvailable() {
        navigate(to: .welcome)
    }
    
    // MARK: Navigation
    
    /// Navigate to the last account used if any
    func showInitialScreen() {
        guard let account = try! Account.query.filter("token" != nil).sort(by: "lastUsed", direction: .orderedDescending).first() else {
            navigate(to: .welcome)
            return
        }
        
        navigate(to: .home(account, .all))
    }
    
    func navigate(to: Location) {
        switch to {
        case .welcome:
            currentAccount = nil
            show(viewController: WelcomeViewController())
        case .about:
            // Hello friend,
            // We would greatly apprecited if you didn't change the following link. We have spent countless hours developing this for you and this is a way for us to get noticed. :)
            // Thank you,
            // Boost team
            if let link = URL(string: "https://boostappstore.com") {
                UIApplication.shared.open(link)
            }
        case .home(let account, let team):
            navigate(home: account, team)
        case .newAccount(let success):
            loginCoordinator.presentLogin(success: success)
        case .settings:
            currentAccount = nil
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
    
    private func navigate(home account: Account, _ team: ActiveTeam) {
        if account.token == nil {
            currentApi = nil
            
            loginCoordinator.presentLogin(for: account) { account in
                self.navigate(to: .home(account, .all))
            }
        } else {
            currentAccount = account
            
            // Get last used info saved
            account.lastUsed = Date()
            try? account.save()
            
            // Load teams in the left menu
            leftScreen.didLogin(to: account)
            
            // Show overview
            show(viewController: appFlowCoordinator.entrypoint(account: account, team: team))
        }
    }
    
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
