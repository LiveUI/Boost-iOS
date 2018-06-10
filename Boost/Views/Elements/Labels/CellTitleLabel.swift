//
//  CellTitleLabel.swift
//  Boost
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


class CellTitleLabel: UILabel {
    
    
    // MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        
        textColor = .black
        font = Font.basicBold(size: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
