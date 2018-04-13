//
//  OnlineIcon.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialPalettes


class OnlineIcon: UIView {
    
    enum State {
        case unknown
        case online
        case offline
    }
    
    
    var state: State {
        didSet {
            switch state {
            case .online:
                backgroundColor = MDCPalette.green.tint500
            case .offline:
                backgroundColor = MDCPalette.red.tint500
            default:
                backgroundColor = MDCPalette.grey.tint500
            }
        }
    }
    
    // MARK: Initialization
    
    init(_ state: State = .unknown) {
        self.state = state
        
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
