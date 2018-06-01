//
//  TableViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import Modular


/// Basic table view controller setup to be Presentable manager
class TableViewController: ViewController, PresentableTableViewManageable {
    
    /// Main table view
    var tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    /// Basic presentable manager
    let presentableManager = PresentableTableViewDataManager()
    
    /// Presentable data
    var data: PresentableSections {
        get { return presentableManager.data }
        set { presentableManager.data = newValue }
    }
    
    // MARK: Data
    
    /// Reload data
    func reloadData() {
        tableView.reloadData()
    }
    
    /// Setup data
    func setupData() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.place.on(andFill: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bind()
    }
    
}
