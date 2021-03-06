//
//  OnlineIcon.swift
//  Boost
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


// TODO: Comment / clean
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
                backgroundColor = UIColor(hex: "479F61")
            case .offline:
                backgroundColor = UIColor(hex: "BE3636")
            default:
                backgroundColor = .gray
            }
        }
    }
    
    // MARK: Layour
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = (bounds.size.width / 2)
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
