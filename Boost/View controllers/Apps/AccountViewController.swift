//
//  AccountViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import Presentables
import BoostSDK
import MarcoPolo
import SideMenu
import UIKit


final class AccountViewController: ViewController {
    
    lazy var menuViewController: MenuViewController = {
        let c = MenuViewController()
        c.api = manager.api
        return c
    }()
    
    /// Main account
    let account: Account
    
    /// Collection view controller
    lazy var collectionView: MyCollectionView = {
        let collectionView = MyCollectionView(frame: .zero, collectionViewLayout: manager.layout)
        collectionView.backgroundColor = .white
        collectionView.register(AppLoadingCell.self)
        collectionView.register(AppCell.self)
//        if UIScreen.main.bounds.width <= 320 {
//            collectionView.contentInset = UIEdgeInsets(top: 10, left: 4, bottom: 12, right: 4)
//        } else {
//            collectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
//        }
        return collectionView
    }()
    
    var refresh = UIRefreshControl()
    
    /// Account data manager
    lazy var manager: AccountDataManager = {
        return AccountDataManager(account) { errorFeedback in
            switch errorFeedback {
            case .notAuthorized, .missingAuthToken:
                self.baseCoordinator.authFailed(forAccount: self.account, in: self)
            default:
                self.baseCoordinator.somethingFailed(forAccount: self.account, in: self)
            }
        }
    }()
    
    /// Reload data
    func reloadData() {
        manager.startLoadingData()
    }
    
    // MARK: Initialization
    
    /// Initializer
    init(_ account: Account) {
        self.account = account
        
        super.init(nibName: nil, bundle: nil)
        
        title = account.name
        
        navigation.set(leftItem: UIImage(named: "navbar/menu-icon")?.asButton(self, action: #selector(didTapMenu(_:))))
        
        navigation.startLoadingData(animated: false)
        manager.didFinishLoading = {
            self.navigation.set(rightItem: UIImage(named: "navbar/menu-search")?.asButton(self, action: #selector(self.didTapSearch(_:))))
        }
    }
    
    // MARK: View lifecycle
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        manager.viewSize = size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.place.on(andFill: view)
        
        var manager = self.manager as PresentableManager
        collectionView.bind(withPresentableManager: &manager)
        
        setupMenu()
        
        collectionView.alwaysBounceVertical = true
        refresh.tintColor = .gray
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refresh)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: Move or add to will rotate method
        let screenSize = view.bounds
        SideMenuManager.default.menuWidth = max(round(min(screenSize.width, screenSize.height) * 0.75), 350)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Only load data when needed!!!!!!
        manager.startLoadingData()
        
        manager.viewSize = view.bounds.size
    }
    
    // MARK: Actions
    
    @objc func refreshData() {
        reloadData()
        refresh.endRefreshing()
    }
    
    // MARK: Setup
    
    func setupMenu() {
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuViewController)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigation.navigationController!.view)
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuShadowRadius = 50
    }
    
    // MARK: Actions
    
    /// Open left menu action
    @objc func didTapMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    /// Open search menu action
    @objc func didTapSearch(_ sender: UIBarButtonItem) {
        
    }
    
}
