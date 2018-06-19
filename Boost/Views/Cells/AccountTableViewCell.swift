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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        icon.image = UIImage.defaultIcon
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        icon.place.on(contentView, top: 16).square(side: 42).left(12).min(bottom: -16)
        
        nameLabel.place.next(to: icon, top: 20, left: 24).right(-12)
        hostLabel.place.below(nameLabel, top:2).match(right: nameLabel).custom { make in
            make.left.equalTo(nameLabel).priority(.high)
        }
        
        let iconOffset: CGFloat = 4
        
        // Lock icon
        let size: CGFloat = 12
        lockIcon.image = Awesome.solid.lock.asImage(size: size, color: .white)
        lockIcon.place.on(contentView).with.match(top: icon, offset: -iconOffset).match(right: icon, offset: iconOffset).make.square(side: size)
        
        // Online icon
        onlineIcon.place.on(contentView).right(-12).centerY().make.square(side: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//class AccountTableViewCell: GridTableViewCell {
//
//    let nameLabel = MenuMainLabel()
//    let hostLabel = MenuSecondaryLabel()
//    let icon = UIImageView()
//    let lockIcon = UIImageView()
//    let onlineIcon = OnlineIcon()
//    let selectedIndicator = UIView()
//
//    override func setupElements() {
//        icon.image = UIImage.defaultIcon
//        icon.layer.cornerRadius = 4
//        icon.clipsToBounds = true
//        gridView.add(subview: icon, 16, from: 0, space: .dynamic) { make in
//            make.width.height.equalTo(42)
//            make.bottom.equalTo(-16)
//        }
//
//        // Lock icon
//        let size: CGFloat = 12
//        let iconOffset: CGFloat = 4
//        lockIcon.image = Awesome.solid.lock.asImage(size: size, color: .black)
//        lockIcon.place.on(icon).with.match(top: icon, offset: -iconOffset).match(right: icon, offset: iconOffset).make.square(side: size)
//        lockIcon.layer.shadowColor = UIColor.white.cgColor
//        lockIcon.layer.masksToBounds = false
//        lockIcon.layer.shadowOpacity = 0.45
//        lockIcon.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 13, height: 13)).cgPath
//        lockIcon.layer.shadowRadius = 1.0
//        lockIcon.layer.shadowOffset = CGSize(width: 10, height: 10)
//
//        //        nameLabel.place.next(to: icon, left: 22).match(top: icon, offset: 3).right(-12)
//        //        hostLabel.place.below(nameLabel, top:2).match(left: nameLabel).match(right: nameLabel)
//
//
//
//        // Online icon
//        //        onlineIcon.place.on(gridView).with.match(bottom: icon, offset: iconOffset).match(right: icon, offset: iconOffset).make.square(side: 10)
//
//        selectedIndicator.backgroundColor = .white
//        selectedIndicator.layer.cornerRadius = 3
//        selectedIndicator.isHidden = true
//        //        selectedIndicator.place.on(contentView, width: 10).match(top: icon).match(bottom: icon).left(-6)
//    }
//
//}
