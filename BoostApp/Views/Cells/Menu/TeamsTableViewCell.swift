//
//  TeamsTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class TeamsTableViewCell: MenuTableViewCell {
    
    let titleLabel = MenuMainLabel()
    let icon = IconView()
    let badge = BadgeView()
    
    let selectedIndicator = UIView()
    
    
    // MARK: Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectedIndicator.backgroundColor = Theme.default.menuSelectionIndicatorColor.hexColor
        selectedIndicator.layer.cornerRadius = 3
        selectedIndicator.isHidden = true
        let margin: CGFloat = 6
        selectedIndicator.place.on(contentView, top: margin, bottom: -margin).sideMargins(left: margin, right: -margin)
        
        icon.imageContentMode = .scaleAspectFill
        icon.place.on(contentView, top: 16).square(side: 38).leftMargin(16).minBottomMargin(-16)
        
        badge.style = .none
        badge.place.on(contentView).centerY().rightMargin(-16).width(44)
        
        titleLabel.place.between(icon, and: badge).centerY()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
