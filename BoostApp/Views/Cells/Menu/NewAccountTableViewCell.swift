//
//  NewAccountTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 31/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import AwesomeEnum


class NewAccountTableViewCell: MenuTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        textLabel?.text = Lang.get("menu.accounts.new_account")
        imageView?.image = Awesome.solid.plus.cellIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
