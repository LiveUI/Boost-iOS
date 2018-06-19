//
//  AccountViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import Presentables


final class AccountViewController: ViewController {
    
    /// Main account
    let account: Account
    
    
    // MARK: Initialization
    
    /// Initializer
    init(_ account: Account) {
        self.account = account
        
        super.init(nibName: nil, bundle: nil)
        
        title = account.name
        
        navigation.set(leftItem: UIImage(named: "navbar/menu-icon")?.asButton(self, action: #selector(didTapMenu(_:))))
        navigation.set(rightItem: UIImage(named: "navbar/menu-search")?.asButton(self, action: #selector(didTapSearch(_:))))
    }
    
    @available(*, unavailable, message: "This method is unavailable")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navigationBar = navigationController?.navigationBar {
            var r = navigationBar.frame
            r.size.height = 214
            navigationBar.frame = r
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions
    
    @objc func didTapMenu(_ sender: UIBarButtonItem) {
        baseCoordinator.requestAccountsList()
    }
    
    @objc func didTapSearch(_ sender: UIBarButtonItem) {
        
    }
    
}
