//
//  AppsViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 30/11/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import Modular
import Awesome
import BoostSDK


class AppsViewController: ViewController {
    
    let dataController = AppsDataManager()
    let collectionView: UICollectionView
    
    
    // MARK: Initialization
    
    init() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    func layoutElements() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Elements
    
    func configureNavBar() {
        let portrait = Awesome.light.list.asImage(size: 22)
        let advanced = UIBarButtonItem(image: portrait, style: .plain, target: self, action: #selector(didTapMenu(_:)))
        navigationItem.rightBarButtonItem = advanced
    }
    
    func configureCollectionView() {
        collectionView.register(AppCollectionViewCell.self)
        
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    override func configureElements() {
        super.configureElements()
        
        configureNavBar()
        configureCollectionView()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutElements()
        
        // Do the binding
        var dc: CollectionViewPresentableManager = dataController
        collectionView.bind(withPresentableManager: &dc)
        
        dataController.loadData()
        
        dataController.appActionRequested = { app in
            self.actionTriggered(for: app)
        }
        dataController.appDetailRequested = { app in
            let c = AppDetailViewController()
            c.appActionRequested = { app in
                self.actionTriggered(for: app)
            }
            c.app = app
            let nc = UINavigationController(rootViewController: c)
            if UIDevice.current.userInterfaceIdiom == .pad {
                nc.modalPresentationStyle = .formSheet
            }
            self.present(nc, animated: true)
        }
    }
    
    // MARK: Actions
    
    func actionTriggered(for app: App) {
        print("Downloading: \(app.name)")
    }
    
    @objc func didTapMenu(_ sender: UIBarButtonItem) {
        
    }
    
}
