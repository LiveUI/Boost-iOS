//
//  MenuViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 10/11/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Base
import UIKit


class MenuViewController: ViewController {
    
    override func setupElements() {
        super.setupElements()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.isTranslucent = false
    }
    
}
