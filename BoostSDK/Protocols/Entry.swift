//
//  Entry.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public protocol AnyEntry {
    var id: UUID? { get }
}

public protocol Entry: Model, AnyEntry, Equatable { }


extension AnyEntry where Self: Entry {
    
    public static func == (lhs: AnyEntry, rhs: AnyEntry) -> Bool {
        return lhs.id == rhs.id && lhs.id != nil
    }
    
}
