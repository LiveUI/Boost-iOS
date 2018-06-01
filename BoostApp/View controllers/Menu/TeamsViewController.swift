//
//  TeamsViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables


class TeamsViewController: MenuViewController {
    
    let manager = TeamsDataManager()
    
    let accountButton = UIButton()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var m = manager as PresentableManager
        tableView.bind(withPresentableManager: &m)
        
        // Top bar elements
        let title = MenuTitleLabel(Lang.get("menu.teams.title"))
        title.place.on(topBar).center().sideToSide()
        
        accountButton.layer.cornerRadius = 3
        accountButton.clipsToBounds = true
        accountButton.addTarget(self, action: #selector(didTapAccountButton(_:)), for: .touchUpInside)
        accountButton.place.on(topBar).leftMargin(16).centerY().make.square(side: 34)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.loadData()
    }
    
    // MARK: Actions
    
    @objc func didTapAccountButton(_ sender: UIButton) {
        leftScreen.show(page: .accounts)
    }
    
}
