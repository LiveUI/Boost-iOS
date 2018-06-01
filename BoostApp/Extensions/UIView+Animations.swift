//
//  UIView+Animations.swift
//  Boost
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func animateLoadingSpinner() {
        let duration: TimeInterval = 0.6
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            self.transform = self.transform.rotated(by: CGFloat.pi)
        }) { finished in
            self.animateLoadingSpinner()
        }
    }
    
}
