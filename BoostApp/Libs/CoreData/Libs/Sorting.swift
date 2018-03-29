//
//  Sorting.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 29/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


/// The types of directions
/// fields can be sorted.
public enum QuerySortDirection {
    case ascending
    case descending
}


/// Sorts results based on a field and direction.
public struct QuerySort {
    /// The field to sort.
    public let field: QueryField
    
    /// The direction to sort by.
    public let direction: QuerySortDirection
    
    /// Create a new sort
    public init(
        field: QueryField,
        direction: QuerySortDirection
        ) {
        self.field = field
        self.direction = direction
    }
}


extension Query {

//    @discardableResult public func sort(sort: QuerySort) -> Self {
//        sorts.append(sort)
//        return self
//    }
    
    // , direction: QuerySortDirection = .ascending
    @discardableResult public func sort<E, T>(by keyPath: ReferenceWritableKeyPath<E, T?>) -> Self where E: AnyEntity {
        let kp = keyPath
        
        func aaa(_ kp: String) {
            print("Path: \(kp)")
        }
        
        aaa(String.init(describing: keyPath.hashValue))
        
        // evaluate the property
//        let s = Sort(field: String(describing: keyPath.), ascending: ascending)
//        sort(by: s)
        return self
    }

}
