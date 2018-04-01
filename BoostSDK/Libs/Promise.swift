//
//  Promise.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public class Promise<Expectation> {
    
    public typealias Success = ((Expectation) throws -> Void)
    public typealias Failure = ((Error) throws -> Void)
    
    var successClosure: Success?
    var errorClosure: Failure?
    
    var fulfilledExpectation: Expectation?
    var fulfilledError: Error?
    
    init() { }
    
    @discardableResult public func then(_ success: @escaping Success) throws -> Self {
        successClosure = success
        if let fulfilledExpectation = fulfilledExpectation {
            try successClosure?(fulfilledExpectation)
        }
        return self
    }
    
    public func error(_ error: @escaping Failure) throws {
        errorClosure = error
        if let fulfilledError = fulfilledError {
            try errorClosure?(fulfilledError)
        }
    }
    
    // MARK: Internal interface
    
    func complete(_ expectation: Expectation) {
        fulfilledExpectation = expectation
        try? successClosure?(expectation)
    }
    
    func fail(_ error: Error) {
        fulfilledError = error
        try? errorClosure?(error)
    }
    
}
