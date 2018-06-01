//
//  SmallTextLabel.swift
//  Boost
//
//  Created by Ondrej Rafaj on 16/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class SmallTextLabel: UILabel {
    
    
    // MARK: Initialization
    
    init(_ title: String? = nil) {
        super.init(frame: CGRect.zero)
        
        text = title
        textColor = .gray
        font = UIFont.systemFont(ofSize: 10)
        textAlignment = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
