//
//  Amazing+BoostApp.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import AwesomeEnum


extension Amazing {
    
    func cellIcon(_ color: UIColor = .white) -> UIImage {
        return asImage(size: 24, color: color)
    }
    
    func navBarIcon(_ color: UIColor = .white) -> UIImage {
        return asImage(size: 24, color: color)
    }
    
}
