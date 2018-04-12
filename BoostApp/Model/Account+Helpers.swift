//
//  Account+Helpers.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension Account {
    
    var iconImage: UIImage {
        guard let data = icon, let image = UIImage(data: data) else {
            return UIImage.defaultIcon
        }
        return image
    }
    
}
