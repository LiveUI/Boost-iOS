//
//  AccountViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import Presentables


final class AccountViewController: ViewController {
    
    /// Main account
    let account: Account
    
    /// Collection view layout
    var layout: UICollectionViewLayout = {
        return UICollectionViewLayout()
    }()
    
    /// Collection view controller
    lazy var collectionView: UICollectionView = {
        return UICollectionView.init(frame: .zero, collectionViewLayout: layout)
    }()
    
    /// Account data manager
    lazy var manager: AccountDataManager = {
        return AccountDataManager(account) { feedback in
            switch feedback {
            case .apiError(let problem):
                switch problem {
                case .notAuthorized, .missingAuthToken:
                    // TODO: Display error message!!!
                    self.baseCoordinator.authFailed(forAccount: self.account, in: self)
                default:
                    self.baseCoordinator.somethingFailed(forAccount: self.account, in: self)
                }
            case .error(let error):
                self.baseCoordinator.somethingFailed(forAccount: self.account, in: self)
            }
        }
    }()
    
    /// Reload data
    func reloadData() {
        manager.getApps()
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
    
    @available(*, unavailable, message: "This method is unavailable")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navigationBar = navigationController?.navigationBar {
            var r = navigationBar.frame
            r.size.height = 214
            navigationBar.frame = r
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.place.on(andFill: view)
        
        var manager = self.manager as PresentableManager
        collectionView.bind(withPresentableManager: &manager)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.getApps()
    }
    
    // MARK: Actions
    
    @objc func didTapMenu(_ sender: UIBarButtonItem) {
        baseCoordinator.requestAccountsList()
    }
    
    @objc func didTapSearch(_ sender: UIBarButtonItem) {
        
    }
    
}
