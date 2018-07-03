//
//  AppCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 28/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


class AppCell: GridCollectionViewCell {
    
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
        
        gridView.config.automaticVerticalSizing = true
        
        gridView.layer.cornerRadius = 8
        gridView.layer.borderWidth = 1
        gridView.layer.borderColor = UIColor(hex: "EBEBEB").withAlphaComponent(0.38).cgColor
        
        // Icon
        iconImage.backgroundColor = .lightGray
        iconImage.layer.cornerRadius = 10
        iconImage.clipsToBounds = true
        gridView.add(subview: iconImage, 14.0, from: .dynamic, space: .dynamic) { make in
            make.width.height.equalTo(64)
            make.centerX.equalToSuperview()
        }
        
        // Title
        titleLabel.font = Font.bold(size: 14)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hex: "888888")
        gridView.add(subview: titleLabel, .below(iconImage, margin: 12), from: 1, space: 10)
        
        // Version
        versionLabel.font = Font.light(size: 10)
        versionLabel.textAlignment = .center
        versionLabel.textColor = titleLabel.textColor
        gridView.add(subview: versionLabel, .below(titleLabel, margin: 6), from: 1, space: 10)
        
        // Action button
        actionButton.layer.cornerRadius = 14
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = UIColor(hex: "979797").withAlphaComponent(0.11).cgColor
        let image = UIImage(named: "button/download")
        actionButton.setImage(image, for: .normal)
//        actionButton.imageView?.contentMode =
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20)
        gridView.add(subview: actionButton, .below(versionLabel, margin: 16), from: .dynamic, space: .dynamic) { make in
            make.height.equalTo(28)
            make.centerX.equalToSuperview()
        }
    }
    
}
