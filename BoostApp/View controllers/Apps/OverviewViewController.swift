//
//  OverviewViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import Modular
import AwesomeEnum
import BoostSDK


class OverviewViewController: RootViewController {
    
    var account: Account {
        didSet {
            title = account.name
        }
    }
    
    
    // MARK: Initialization
    
    init(account: Account) {
        self.account = account
        
        let manager = OverviewDataManager()
        super.init(manager: manager)
        
        manager.allBuildsRequested = { app in
            let c = AppsViewController(leadingApp: app)
            c.tags = super.filtersMenu.dataController.selectedTags
            self.navigationController?.pushViewController(c, animated: true)
        }
        manager.deleteAllRequested = { app in
            let alert = UIAlertController(title: "Really?!", message: "This may fuck shit up dude!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Elements
    
    override func configureElements() {
        super.configureElements()
    }
    
}
