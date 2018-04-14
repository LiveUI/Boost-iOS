//
//  String+Color.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 14/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit


extension String {
    
    var hexColor: UIColor? {
        return UIColor(hex: self)
    }
    
}


extension String {
    
    struct RGBColor {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
    }
    
    var rgbColor: RGBColor? {
        let length = self.count
        if length == 6 {
            return rgbColorFromSixCharacterHex()
        } else if length == 8 {
            return rgbColorFromEightCharacterHex()
        } else {
            return nil
        }
    }
    
    func hexInt32() -> UInt32? {
        var rgb: UInt32 = 0
        guard Scanner(string: self).scanHexInt32(&rgb) else {
            return nil
        }
        return rgb
    }
    
    func rgbColorFromSixCharacterHex() -> RGBColor? {
        guard let rgb = hexInt32() else {
            return nil
        }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        return RGBColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func rgbColorFromEightCharacterHex() -> RGBColor? {
        guard let rgb = hexInt32() else {
            return nil
        }
        
        let red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
        let blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
        let alpha = CGFloat(rgb & 0x000000FF) / 255.0
        return RGBColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var hashesStripped: String {
        return self.replacingOccurrences(of: "#", with: "")
    }
    
    var hexSanitized: String {
        return self.trimmed.hashesStripped
    }
    
}
