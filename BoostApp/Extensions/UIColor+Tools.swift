//
//  UIColor+Tools.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 14/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    convenience init?(hex: String) {
        guard let rgbColor = hex.hexSanitized.rgbColor else {
            return nil
        }
        
        self.init(red: rgbColor.red,
                  green: rgbColor.green,
                  blue: rgbColor.blue,
                  alpha: rgbColor.alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        precondition(red >= 0 && red <= 255, "Invalid red component")
        precondition(green >= 0 && green <= 255, "Invalid green component")
        precondition(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
}
