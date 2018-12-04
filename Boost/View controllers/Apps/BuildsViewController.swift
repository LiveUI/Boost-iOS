//
//  BuildsViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/07/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import Presentables
import BoostSDK


final class BuildsViewController: ViewController {
    
    /// Main account
    let api: Api
    
    /// App overview
    let overview: Overview
    
    /// Collection view controller
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: manager.layout)
        collectionView.backgroundColor = .white
        collectionView.register(AppLoadingCell.self)
        collectionView.register(BuildCell.self)
        if UIScreen.main.bounds.width <= 320 {
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 4, bottom: 12, right: 4)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
        return collectionView
    }()
    
    /// Account data manager
    lazy var manager: BuildsDataManager = {
        return BuildsDataManager(api, overview: overview) { feedback in
            switch feedback {
            case .notAuthorized, .missingAuthToken:
                break
                // Remove an invalid token from the account
//                self.account.token = nil
//                try? self.account.save()
                // TODO: Display error message!!!
//                self.baseCoordinator.authFailed(forAccount: self.account, in: self)
            default:
                break
//                self.baseCoordinator.somethingFailed(forAccount: self.account, in: self)
            }
        }
    }()
    
    /// Reload data
    func reloadData() {
        manager.startLoadingData()
    }
    
    // MARK: Initialization
    
    /// Initializer
    init(_ overview: Overview, api: Api) {
        self.api = api
        self.overview = overview
        
        super.init(nibName: nil, bundle: nil)
        
        navigation.set(rightItem: UIImage(named: "navbar/menu-search")?.asButton(self, action: #selector(didTapSearch(_:))))
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.place.on(andFill: view)
        
        var manager = self.manager as PresentableManager
        collectionView.bind(withPresentableManager: &manager)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigation.content.title = overview.latestName
        navigation.content.subtitle = "\(overview.count) builds"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Only load data when needed!!!!
        manager.startLoadingData()
    }
    
    // MARK: Actions
    
    /// Open search menu action
    @objc func didTapSearch(_ sender: UIBarButtonItem) {
        
    }
    
}
