//
//  QueryConvertible.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 29/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public protocol QueryConvertible {
    var entity: AnyEntity.Type { get }
    
    var sorts: [QuerySort] { get set }
    
    init(_ entityType: AnyEntity.Type)
}


extension QueryConvertible {
    
    /// Get compiled fetch request
    public func fetchRequest() -> Entity.Request {
        let fetch = Entity.Request(entityName: entity.entityName)
        // TODO: Do the fetch
        return fetch
    }
    
}
