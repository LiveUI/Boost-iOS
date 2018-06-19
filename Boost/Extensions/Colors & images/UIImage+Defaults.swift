//
//  UIImage+Defaults.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    static var defaultIcon: UIImage {
        guard let image = UIImage(named: "default/icon") else {
            fatalError("Default icon is missing!")
        }
        return image
    }
    
}
