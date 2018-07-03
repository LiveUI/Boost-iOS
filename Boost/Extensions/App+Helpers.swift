//
//  App+Helpers.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/07/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import BoostSDK


extension UUID {
    
    func download(app api: Api, finished: @escaping (() -> Void)) throws {
        try api.auth(app: self).then({ appAuth in
            print(appAuth)
            DispatchQueue.main.async {
                finished()
                guard let url = URL(string: appAuth.plist) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
    }
    
}
