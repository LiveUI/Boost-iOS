//
//  AppHeaderView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 13/07/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Base


class AppHeaderView: GridTableViewHeaderFooterView {
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let bundleIdLabel = UILabel()
    let buildsLabel = UILabel()
    let showAllButton = UIButton()
    
    // MARK: Elements
    
    override func setupElements() {
        super.setupElements()
        
        gridView.config.automaticVerticalSizing = true
        gridView.config.padding = .horizontal(left: 12, right: 12)
        
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.numberOfLines = 0
        titleLabel.font = Font.basic(size: 12)
        titleLabel.textColor = .darkText
        gridView.add(subview: titleLabel, .toTop, from: 0, space: 12)
        
        bundleIdLabel.numberOfLines = 0
        bundleIdLabel.font = Font.basic(size: 12)
        bundleIdLabel.textColor = .darkText
        gridView.add(subview: bundleIdLabel, .below(titleLabel), from: 0, space: 12)
        
        gridView.snp.remakeConstraints { make in
            make.top.equalTo(0)
            make.left.right.equalToSuperview()
            make.bottom.greaterThanOrEqualTo(0)
        }
    }
    
}
