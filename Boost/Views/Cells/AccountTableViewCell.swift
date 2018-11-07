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
import Base


class AccountTableViewCell: TableViewCell {
    
    let nameLabel = MenuMainLabel()
    let hostLabel = MenuSecondaryLabel()
    let icon = UIImageView()
    let lockIcon = UIImageView()
    let onlineIcon = OnlineIcon()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        backgroundView?.backgroundColor = .white
        contentView.backgroundColor = .white
        
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        icon.place.on(contentView, top: 16).square(side: 42).left(12).min(bottom: -16)
        
        nameLabel.place.next(to: icon, top: 20, left: 24).right(-12)
        hostLabel.place.below(nameLabel, top:2).match(right: nameLabel).custom { make in
            make.left.equalTo(nameLabel).priority(.high)
        }
        
//        let iconOffset: CGFloat = 4
//
//        // Lock icon
//        let size: CGFloat = 12
//        lockIcon.image = Awesome.solid.lock.asImage(size: size, color: .white)
//        lockIcon.place.on(contentView).with.match(top: icon, offset: -iconOffset).match(right: icon, offset: iconOffset).make.square(side: size)
        
        // Online icon
        onlineIcon.place.on(contentView).right(-12).centerY().make.square(side: 12)
    }
    
}
