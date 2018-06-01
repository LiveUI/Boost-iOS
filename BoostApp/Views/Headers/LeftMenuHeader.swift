//
//  LeftMenuHeader.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular


class LeftMenuHeader: UICollectionReusableView {
    
    var titleLabel = UILabel()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.place.on(self).with.leftMargin(6).rightMargin(6).topToBottom()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
