//
//  FiltersViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
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
        var dc: PresentableManager = dataController
        tableView.bind(withPresentableManager: &dc)
        
    }
    
}
