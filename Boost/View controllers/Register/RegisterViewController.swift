//
//  RegisterViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Base


class RegisterViewController: GridViewController {
    
    var didFinish:((Account) -> Void)?
    
    let logo = UIImageView()
    
    let selector = UIView()
    
    
    // MARK: Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gridView.backgroundColor = .blue
        gridView.config.displayGrid = true

        logo.backgroundColor = .orange
        gridView.add(subview: logo, 110, from: .dynamic, space: .dynamic) { make in
            make.width.height.equalTo(92)
            make.centerX.equalToSuperview()
        }

        gridView.add(subview: selector, .below(logo, margin: 90)) { make in
            make.height.equalTo(32)
        }
    }
    
}
