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
    
    var randomColor: UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    public func hex(hashPrefix: Bool = true) -> String {
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let prefix = hashPrefix ? "#" : ""
        
        return String(format: "\(prefix)%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
    internal func rgb() -> [CGFloat] {
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return [r, g, b]
    }
    
    public var isDark: Bool {
        let RGB = rgb()
        return (0.2126 * RGB[0] + 0.7152 * RGB[1] + 0.0722 * RGB[2]) < 0.5
    }
    
    public var isBlackOrWhite: Bool {
        let RGB = rgb()
        return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91) || (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
    }
    
    public var isBlack: Bool {
        let RGB = rgb()
        return (RGB[0] < 0.09 && RGB[1] < 0.09 && RGB[2] < 0.09)
    }
    
    public var isWhite: Bool {
        let RGB = rgb()
        return (RGB[0] > 0.91 && RGB[1] > 0.91 && RGB[2] > 0.91)
    }
    
    public func isDistinct(from color: UIColor) -> Bool {
        let bg = rgb()
        let fg = color.rgb()
        let threshold: CGFloat = 0.25
        var result = false
        
        if fabs(bg[0] - fg[0]) > threshold || fabs(bg[1] - fg[1]) > threshold || fabs(bg[2] - fg[2]) > threshold {
            if fabs(bg[0] - bg[1]) < 0.03 && fabs(bg[0] - bg[2]) < 0.03 {
                if fabs(fg[0] - fg[1]) < 0.03 && fabs(fg[0] - fg[2]) < 0.03 {
                    result = false
                }
            }
            result = true
        }
        
        return result
    }
    
    public func isContrasting(with color: UIColor) -> Bool {
        let bg = rgb()
        let fg = color.rgb()
        
        let bgLum = 0.2126 * bg[0] + 0.7152 * bg[1] + 0.0722 * bg[2]
        let fgLum = 0.2126 * fg[0] + 0.7152 * fg[1] + 0.0722 * fg[2]
        let contrast = bgLum > fgLum
            ? (bgLum + 0.05) / (fgLum + 0.05)
            : (fgLum + 0.05) / (bgLum + 0.05)
        
        return 1.6 < contrast
    }
    
}
