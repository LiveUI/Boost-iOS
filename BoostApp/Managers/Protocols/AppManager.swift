//
//  AppManager.swift
//  Boost
//
//  Created by Ondrej Rafaj on 16/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import BoostSDK


protocol AppManager {
    var appDetailRequested: ((App)->())? { get set }
    var appActionRequested: ((App)->())? { get set }
}
