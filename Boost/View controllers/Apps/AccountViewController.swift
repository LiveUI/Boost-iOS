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


final class AccountViewController: ViewController {
    
    /// Main account
    let account: Account
    
    /// Collection view controller
    lazy var collectionView: MyCollectionView = {
        let collectionView = MyCollectionView(frame: .zero, collectionViewLayout: manager.layout)
        collectionView.backgroundColor = .white
        collectionView.register(AppLoadingCell.self)
        collectionView.register(AppCell.self)
        if UIScreen.main.bounds.width <= 320 {
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 4, bottom: 12, right: 4)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
        return collectionView
    }()
    
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
        navigation.set(rightItem: UIImage(named: "navbar/menu-search")?.asButton(self, action: #selector(didTapSearch(_:))))
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.startLoadingData()
        
        manager.viewSize = view.bounds.size
    }
    
    // MARK: Actions
    
    /// Open left menu action
    @objc func didTapMenu(_ sender: UIBarButtonItem) {
        baseCoordinator.requestAccountsList()
    }
    
    /// Open search menu action
    @objc func didTapSearch(_ sender: UIBarButtonItem) {
        
    }
    
}
