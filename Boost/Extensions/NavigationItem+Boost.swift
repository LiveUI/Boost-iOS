//
//  NavigationItem+Boost.swift
//  Boost
//
//  Created by Ondrej Rafaj on 08/11/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import MarcoPolo


extension NavigationItem {
    
    func startLoadingData(animated: Bool = true) {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        ai.startAnimating()
        ai.sizeToFit()
        set(rightItem: ai)
    }
    
}
