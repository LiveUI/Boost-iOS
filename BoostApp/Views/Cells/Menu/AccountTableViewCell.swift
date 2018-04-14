//
//  AccountTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 31/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular
import AwesomeEnum


class AccountTableViewCell: MenuTableViewCell {
    
    let nameLabel = MenuMainLabel()
    let hostLabel = MenuSecondaryLabel()
    let icon = UIImageView()
    let lockIcon = UIImageView()
    let onlineIcon = OnlineIcon()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        icon.place.on(contentView, top: 6).square(side: 38).leftMargin(6).minBottomMargin(-6)
        
        icon.image = UIImage.defaultIcon
        
        nameLabel.place.next(to: icon, left: 16).topMargin(0).rightMargin(-6)
        hostLabel.place.below(nameLabel, top:2).rightMargin(-6).match(width: nameLabel)
        
        // Lock icon
        let size: CGFloat = 14
        lockIcon.image = Awesome.solid.lock.asImage(size: size, color: .white)
        lockIcon.place.on(icon).with.topMargin(-6).rightMargin(6).make.square(side: size)
        
        // Online icon
        onlineIcon.place.on(icon).bottomMargin(4).rightMargin(4).square(side: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
