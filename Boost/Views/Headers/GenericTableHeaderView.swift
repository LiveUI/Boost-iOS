//
//  GenerictTableHeaderView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 11/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Base


class GenericTableHeaderView: GridTableViewHeaderFooterView {
    
    let title = UILabel()
    
    // MARK: Elements
    
    override func setupElements() {
        super.setupElements()
        
        gridView.config.automaticVerticalSizing = true
        
        title.numberOfLines = 0
        title.font = Font.basic(size: 12)
        title.textColor = .darkText
        gridView.add(subview: title, .toTop)
        
        gridView.snp.remakeConstraints { make in
            make.top.equalTo(6)
            make.left.equalTo(12)
            make.right.equalToSuperview()
            make.bottom.equalTo(-6)
        }
    }
    
}
