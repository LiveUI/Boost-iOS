//
//  GradientView+Boost.swift
//  Boost
//
//  Created by Ondrej Rafaj on 28/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base


extension GradientView.Config {
    
    /// Four color config
    static func new(for color1: UIColor, color2: UIColor, color3: UIColor, color4: UIColor) -> GradientView.Config {
        return GradientView.Config([
            GradientView.Config.Color(color: color1, position: 0),
            GradientView.Config.Color(color: color2, position: 0.35),
            GradientView.Config.Color(color: color3, position: 0.7),
            GradientView.Config.Color(color: color4, position: 1)
            ], angle: -45
        )
    }
    
    /// Basic color config
    static func basic() -> GradientView.Config {
        return new(
            for: UIColor(hex: "CE4CE6"),
            color2: UIColor(hex: "DE4DCB"),
            color3: UIColor(hex: "EF5395"),
            color4: UIColor(hex: "FA4A6F")
        )
    }
    
}
