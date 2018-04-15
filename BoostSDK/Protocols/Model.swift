//
//  Model.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public protocol AnyModel { }

public protocol Model: AnyModel, Codable { }
