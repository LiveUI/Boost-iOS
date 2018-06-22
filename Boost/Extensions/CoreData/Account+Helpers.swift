//
//  Account+Helpers.swift
//  Boost
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension Account {
    
    /// Invalid token notification
    static let InvalidToken: NSNotification.Name = NSNotification.Name("InvalidAccountToken")
    
    /// Server icon with a default option
    var iconImage: UIImage {
        guard let data = icon, let image = UIImage(data: data) else {
            return UIImage.defaultIcon
        }
        return image
    }
    
    /// Report auth token is invalid
    func reportInvalidAuthToken() throws {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Account.InvalidToken, object: self)
            self.token = nil
            try? self.save()
        }
    }
    
    /// Is server online?
    var onlineIsValid: Bool {
        if online == true && lastSeen?.timeIntervalSince1970 ?? 0 > Date().addingTimeInterval(-(10 * 60)).timeIntervalSince1970 {
            return true
        }
        return false
    }
    
    static func refreshOnlineStatus(_ finished: @escaping ((Account) -> Void)) throws {
        let accounts = try Account.all()
        for account in accounts {
            try account.api().ping().then { pong in
                DispatchQueue.main.async {
                    account.online = true
                    account.lastSeen = Date()
                    try? account.save()
                    finished(account)
                }}.error { error in
                    DispatchQueue.main.async {
                        account.online = false
                        try? account.save()
                        finished(account)
                    }
            }
        }
    }
    
}
