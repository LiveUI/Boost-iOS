//
//  TeamTableViewCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 02/12/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular
import AwesomeEnum
import Base
import BoostSDK


class TeamTableViewCell: TableViewCell {
    
    var team: Team? {
        didSet {
            guard let team = team else {
                return
            }
            nameLabel.text = team.name
            subtitleLabel.text = "Loading ..."
            icon.backgroundColor = UIColor(hex: team.color)
        }
    }
    
    var info: TeamAppInfo? {
        didSet {
            guard let info = info else {
                return
            }
            subtitleLabel.text = "\(info.apps) apps, \(info.builds) builds"
        }
    }
    
    let nameLabel = MenuMainLabel()
    let subtitleLabel = MenuSecondaryLabel()
    let icon = UIImageView()
    let lockIcon = UIImageView()
    let onlineIcon = OnlineIcon()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        icon.place.on(contentView, top: 16).square(side: 42).left(14).min(bottom: -16)
        
        nameLabel.textColor = .white
        nameLabel.place.next(to: icon, top: 20, left: 24).right(-14)
        
        subtitleLabel.place.below(nameLabel, top:2).match(right: nameLabel).custom { make in
            make.left.equalTo(nameLabel).priority(.high)
        }
                
        // Online icon
        onlineIcon.place.on(contentView).right(-12).centerY().make.square(side: 12)
    }
    
}
