//
//  Query.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 29/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public class Query: QueryConvertible {
    
    public var entity: AnyEntity.Type
    
    public var sorts: [QuerySort] = []
    
    public var predicate: NSPredicate? = nil
    
    public required init(_ entityType: AnyEntity.Type) {
        self.entity = entityType
    }
    
}
