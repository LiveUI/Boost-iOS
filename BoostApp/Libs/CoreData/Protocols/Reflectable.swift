//
//  Reflectable.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 29/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public protocol Reflectable {
    /// Reflects all of this type's `ReflectedProperty`s.
    static func reflectProperties() throws -> [ReflectedProperty]
    
    /// Returns a `ReflectedProperty` for the supplied key path.
    static func reflectProperty<T>(forKey keyPath: KeyPath<Self, T>) throws -> ReflectedProperty?
}

/// Represents a property on a type that has been reflected using the `Reflectable` protocol.
public struct ReflectedProperty {
    /// This property's type.
    public let type: Any.Type
    
    /// The path to this property.
    public let path: [String]
    
    /// Creates a new `ReflectedProperty` from a type and path.
    public init<T>(_ type: T.Type, at path: [String]) {
        self.type = T.self
        self.path = path
    }
    
    /// Creates a new `ReflectedProperty` using `Any.Type` and a path.
    public init(any type: Any.Type, at path: [String]) {
        self.type = type
        self.path = path
    }
}

extension ReflectedProperty: CustomStringConvertible {
    /// See CustomStringConvertible.description
    public var description: String {
        return "\(path.joined(separator: ".")): \(type)"
    }
}
