//
//  Style.swift
//  Boost
//
//  Created by Ondrej Rafaj on 08/11/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public struct StylesProperty<ElementType> {
    
    let element: ElementType
    
    init(_ obj: ElementType) {
        element = obj
    }
    
}

public protocol StylesPropertyProtocol {
    associatedtype PropertyParentType
    var style: StylesProperty<PropertyParentType> { get }
}

extension StylesPropertyProtocol {
    
    public var style: StylesProperty<Self> {
        return StylesProperty(self)
    }
    
}

extension UIView: StylesPropertyProtocol { }
