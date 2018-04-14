//
//  SettingsTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 31/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import AwesomeEnum


class SettingsTableViewCell: MenuTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        textLabel?.text = Lang.get("menu.accounts.settings")
        imageView?.image = Awesome.solid.cogs.cellIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
