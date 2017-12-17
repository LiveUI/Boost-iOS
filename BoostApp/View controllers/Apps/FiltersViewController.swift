//
//  FiltersViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables


class FiltersViewController: UITableViewController {
    
    let dataController = FiltersDataManager()
    var tagsChanged: (([String])->())?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataController.loadData()
        dataController.tagsChanged = {
            self.tagsChanged?(self.dataController.selectedTags)
        }
        var dc: TableViewPresentableManager = dataController
        tableView.bind(withPresentableManager: &dc)
        
    }
    
}
