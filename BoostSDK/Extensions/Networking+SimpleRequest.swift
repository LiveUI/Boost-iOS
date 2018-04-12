//
//  Networking+SimpleRequest.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 08/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


extension Networking {
    
    func get<T>(path: String) throws -> Promise<T> where T: Decodable {
        let promise = Promise<T>()
        try get(path: path) { (res) in
            do {
                let object = try res.unwrap(to: T.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
    func post<T>(path: String, data: Data) throws -> Promise<T> where T: Decodable {
        let promise = Promise<T>()
        try post(path: path, data: data) { (res) in
            do {
                let object = try res.unwrap(to: T.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
    func post<T>(path: String, object: Encodable) throws -> Promise<T> where T: Decodable {
        let promise = Promise<T>()
        try post(path: path, object: object) { (res) in
            do {
                let object = try res.unwrap(to: T.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
    func put<T>(path: String, data: Data) throws -> Promise<T> where T: Decodable {
        let promise = Promise<T>()
        try put(path: path, data: data) { (res) in
            do {
                let object = try res.unwrap(to: T.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
    func put<T>(path: String, object: Encodable) throws -> Promise<T> where T: Decodable {
        let promise = Promise<T>()
        try put(path: path, object: object) { (res) in
            do {
                let object = try res.unwrap(to: T.self)
                promise.complete(object)
            } catch {
                promise.fail(error)
            }
        }
        return promise
    }
    
    func delete(path: String) throws -> Promise<Void> {
        let promise = Promise<Void>()
        try delete(path: path) { res in
            switch res {
            case .error(let error):
                promise.fail(error ?? Problem.unknownError)
            default:
                promise.complete(Void())
            }
        }
        return promise
    }
    
}
