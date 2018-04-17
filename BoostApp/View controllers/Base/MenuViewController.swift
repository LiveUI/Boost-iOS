//
//  MenuViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class MenuViewController: ViewController {
    
    let topBar = MenuTopBarView()
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.default.menuBackgroundColor.hexColor
        
        topBar.place.on(view, top: 0).sideToSide().with.height(54)
        
        tableView.place.below(topBar, top: 0).sideToSide().bottomMargin(-20)
        tableView.removeEmptyRows()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
}


extension MenuViewController {
    
    var leftScreen: LeftMenuViewController {
        return baseCoordinator.leftScreen
    }
    
}
