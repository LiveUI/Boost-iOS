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
    
    
    // MARK: Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        icon.layer.cornerRadius = 4
        icon.clipsToBounds = true
        icon.imageContentMode = .center
        icon.place.on(contentView, top: 16).square(side: 38).leftMargin(16).minBottomMargin(-16)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.place.next(to: icon, left: 22).centerY().rightMargin(-12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
