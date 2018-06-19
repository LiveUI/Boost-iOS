//
//  UIImage+UIButton.swift
//  Boost
//
//  Created by Ondrej Rafaj on 19/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    func asButton(_ target: Any, action: Selector) -> UIButton {
        let b = UIButton()
        b.setImage(self, for: .normal)
        b.addTarget(target, action: action, for: .touchUpInside)
        return b
    }
    
}


extension Optional where Wrapped: UIImage {
    
    func asButton(_ target: Any, action: Selector) -> UIButton {
        guard let image = self else {
            fatalError("Image doesn't exist")
        }
        return image.asButton(target, action: action)
    }
    
}
