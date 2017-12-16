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


class HomeViewController: ViewController {
    
    let dataController = AppsDataManager()
    let tableView = UITableView()
    
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    func configureTableDataSource() {
        
    }
    
    override func configureElements() {
        super.configureElements()
    }
    
}
