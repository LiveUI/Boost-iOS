//
//  AccountViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 27/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


final class AccountViewController: ViewController {
    
    /// Main account
    let account: Account
    
    
    // MARK: Initialization
    
    /// Initializer
    init(_ account: Account) {
        self.account = account
        
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Stay away from this initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
