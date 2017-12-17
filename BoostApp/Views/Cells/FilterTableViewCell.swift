//
//  FilterTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables


class FilterTableViewCell: UITableViewCell, Presentable {
    
    
    // MARK: Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        detailTextLabel?.layer.borderWidth = 1
        detailTextLabel?.layer.borderColor = UIColor.lightGray.cgColor
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


class FilterTableViewCellPresenter: SelectablePresenter {
    
    var didSelectCell: (() -> ())?
    
    var presentable: Presentable.Type = FilterTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
