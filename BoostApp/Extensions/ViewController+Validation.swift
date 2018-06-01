//
//  ViewController+Validation.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension ViewController {
    
    @discardableResult func validate() -> Bool {
        var ok = true
        view.subviews.forEach { view in
            if let validatable = view as? Validatable {
                if !validatable.isValid {
                    ok = false
                }
                validatable.checkIsValid(nil)
            }
        }
        return ok
    }
    
}
