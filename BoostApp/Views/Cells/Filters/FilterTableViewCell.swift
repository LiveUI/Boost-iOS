//
//  FilterTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class FilterTableViewCell: UITableViewCell {
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        detailTextLabel?.layer.borderWidth = 1
        detailTextLabel?.layer.borderColor = UIColor.white.cgColor
        detailTextLabel?.layer.cornerRadius = 6
    }
    
    // MARK: Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

