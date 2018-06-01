//
//  CGSize+Tools.swift
//  Boost
//
//  Created by Ondrej Rafaj on 16/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import CoreGraphics


extension CGSize {
    
    var bigger: CGFloat {
        return max(width, height)
    }
    
    var smaller: CGFloat {
        return min(width, height)
    }
    
    var isLandscape: Bool {
        return width > height
    }
    
    var isPortrait: Bool {
        return width < height
    }
    
}
