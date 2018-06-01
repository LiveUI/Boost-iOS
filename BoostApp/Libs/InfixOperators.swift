//
//  InfixOperators.swift
//  Boost
//
//  Created by Ondrej Rafaj on 22/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


infix operator >!<

func >!< (item1: AnyObject, item2: AnyObject) -> Bool {
    return type(of: item1) === type(of: item2)
}
