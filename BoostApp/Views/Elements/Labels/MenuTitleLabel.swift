//
//  MenuTitleLabel.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class MenuTitleLabel: UILabel {
    
    
    // MARK: Initialization
    
    init(_ title: String? = nil) {
        super.init(frame: CGRect.zero)
        
        text = title
        textColor = .white
        font = UIFont.boldSystemFont(ofSize: 14)
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
