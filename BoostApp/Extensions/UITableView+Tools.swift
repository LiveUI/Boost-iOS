//
//  UITableView+Tools.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


extension UITableView {
    
    func removeEmptyRows() {
        tableFooterView = UIView()
    }
    
    func topMenuSpacing() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        tableHeaderView = view
    }
    
}
