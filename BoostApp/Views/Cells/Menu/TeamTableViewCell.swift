//
//  TeamTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import AwesomeEnum
import Modular


class TeamTableViewCell: MenuTableViewCell {
    
    let icon = TeamIconView()
    let nameLabel = CellTitleLabel()
    
    
    // MARK: Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        icon.place.on(contentView, top: 6).leftMargin(12).make.square(side: 36).minBottomMargin(-6)
        nameLabel.place.next(to: icon, left: 12).centerY().rightMargin(12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
