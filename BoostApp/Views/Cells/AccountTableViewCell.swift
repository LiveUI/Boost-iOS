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
    
    let lockIcon = UIImageView()
    let icon = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        imageView?.image = UIImage(named: "Defaults/icon-40")
        if let imageView = imageView {
            let size: CGFloat = 20
            let padding: CGFloat = 3
            let innerSize = (size - (2 * padding))
            lockIcon.image = Awesome.solid.lock.asImage(size: size, color: .darkGray)
            lockIcon.place.on(imageView).with.topMargin(-6).rightMargin(6).make.square(side: size)
            let innerLock = UIImageView(image: Awesome.solid.lock.asImage(size: innerSize, color: .white))
            innerLock.place.on(lockIcon).center().make.square(side: innerSize)
        }
        
        accessoryType = .detailDisclosureButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
