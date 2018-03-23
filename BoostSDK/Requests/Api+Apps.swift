//
//  Api+Apps.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation


extension Api {
    
    public func apps(identifier: String? = nil, platform: App.Platform? = nil, paging: Paging = Paging(), _ result: ((_ result: Result<[App]>)->())) {
        if identifier == nil {
            result(Result.success(getAppFileTemp(name: "all")))
        } else {
            result(Result.success(getAppFileTemp(name: "builds")))
        }
    }
    
}
