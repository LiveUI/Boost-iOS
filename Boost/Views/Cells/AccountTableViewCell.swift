//
//  AccountTableViewCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 31/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular
import AwesomeEnum


class AccountTableViewCell: UITableViewCell {
    
    let nameLabel = MenuMainLabel()
    let hostLabel = MenuSecondaryLabel()
    let icon = UIImageView()
    let lockIcon = UIImageView()
    let onlineIcon = OnlineIcon()
    let selectedIndicator = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        icon.image = UIImage.defaultIcon
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        icon.place.on(contentView, top: 16).square(side: 38).left(16).min(bottom: -16)
        
        nameLabel.place.next(to: icon, left: 22).match(top: icon, offset: 3).right(-12)
        hostLabel.place.below(nameLabel, top:2).match(left: nameLabel).match(right: nameLabel)
        
        let iconOffset: CGFloat = 4
        
        // Lock icon
        let size: CGFloat = 12
        lockIcon.image = Awesome.solid.lock.asImage(size: size, color: .white)
        lockIcon.place.on(contentView).with.match(top: icon, offset: -iconOffset).match(right: icon, offset: iconOffset).make.square(side: size)
        
        // Online icon
        onlineIcon.place.on(contentView).with.match(bottom: icon, offset: iconOffset).match(right: icon, offset: iconOffset).make.square(side: 10)
        
        selectedIndicator.backgroundColor = .white
        selectedIndicator.layer.cornerRadius = 3
        selectedIndicator.isHidden = true
        selectedIndicator.place.on(contentView, width: 10).match(top: icon).match(bottom: icon).left(-6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
