//
//  MenuMainLabel.swift
//  Boost
//
//  Created by Ondrej Rafaj on 14/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


class MenuMainLabel: UILabel {
    
    
    // MARK: Initialization
    
    init(_ title: String? = nil) {
        super.init(frame: CGRect.zero)
        
        text = title
        textColor = .darkText
        font = Font.bold(size: 14)
        textAlignment = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
