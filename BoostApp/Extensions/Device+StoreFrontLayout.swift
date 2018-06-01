//
//  Device+StoreFrontLayout.swift
//  Boost
//
//  Created by Ondrej Rafaj on 16/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import CoreGraphics


extension Device {
    
    var minCellWidth: CGFloat {
        switch self {
        case .phone:
            return 300
        case .tablet:
            return 310
        case .tv:
            return 450
        }
    }
    
}
