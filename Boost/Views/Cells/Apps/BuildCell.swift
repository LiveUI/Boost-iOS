//
//  BuildCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/07/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


class BuildCell: GridCollectionViewCell {
    
    enum Style {
        case card
    }
    
    var style: Style = .card
    
    let iconImage = UIImageView()
    let titleLabel = UILabel()
    let versionLabel = UILabel()
    let actionButton = HighlightedButton()
    
    override func setupElements() {
        super.setupElements()
        
        // Title
        titleLabel.font = Font.basic(size: 12)
        titleLabel.textColor = UIColor(hex: "888888")
        gridView.add(subview: titleLabel, 4.0, from: 0, space: .reversed(3))
        
        // Version
        versionLabel.font = Font.light(size: 10)
        versionLabel.textColor = titleLabel.textColor
        gridView.add(subview: versionLabel, .below(titleLabel, margin: 6), from: 0, space: .reversed(3))
        
        // Action button
        actionButton.layer.cornerRadius = 14
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = UIColor(hex: "979797").withAlphaComponent(0.11).cgColor
        let image = UIImage(named: "button/download")
        actionButton.setImage(image, for: .normal)
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20)
        gridView.add(subview: actionButton, .centerY, from: .reversed(3), space: 3) { make in
            make.height.equalTo(28)
        }
    }
    
}
