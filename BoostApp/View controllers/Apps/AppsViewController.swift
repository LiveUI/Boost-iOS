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


class AppsViewController: RootViewController {
    
    
    // MARK: Initialization
    
    init(leadingApp: App) {
        super.init()
        
        title = leadingApp.name
        
        dataController = AppsDataManager(leadingApp: leadingApp)
        
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
    }
    
}
