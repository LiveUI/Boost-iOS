//
//  HomeViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import Modular
import Awesome
import BoostSDK


class HomeViewController: RootViewController {
    
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        let dataController = HomeDataManager()
        dataController.allBuildsRequested = { app in
            let c = AppsViewController(leadingApp: app)
            c.tags = super.filtersMenu.dataController.selectedTags
            self.navigationController?.pushViewController(c, animated: true)
        }
        dataController.deleteAllRequested = { app in
            let alert = UIAlertController(title: "Really?!", message: "This may fuck shit up dude!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.dataController = dataController
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.register(header: AppHeader.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
    }
    
}
