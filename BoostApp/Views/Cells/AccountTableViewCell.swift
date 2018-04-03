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


class AccountTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let hostLabel = UILabel()
    let icon = UIImageView()
    let lockIcon = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .detailDisclosureButton
        
        icon.place.on(contentView).square(side: 44).leftMargin(6).centerY()
        icon.image = UIImage(named: "Defaults/icon-40")
        
        nameLabel.place.next(to: icon, left: 16).topMargin(6).rightMargin(-6)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        
        hostLabel.place.below(nameLabel, top:6).rightMargin(-6).match(width: nameLabel)
        hostLabel.textColor = .gray
        hostLabel.font = UIFont.systemFont(ofSize: 12)
        
        // Lock icon
        let size: CGFloat = 20
        let padding: CGFloat = 3
        let innerSize = (size - (2 * padding))
        lockIcon.image = Awesome.solid.lock.asImage(size: size, color: .darkGray)
        lockIcon.place.on(icon).with.topMargin(-6).rightMargin(6).make.square(side: size)
        let innerLock = UIImageView(image: Awesome.solid.lock.asImage(size: innerSize, color: .white))
        innerLock.place.on(lockIcon).center().make.square(side: innerSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
