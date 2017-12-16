//
//  Result.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation


public enum Result<T> {
    case error(Error?)
    case success(T)
}
