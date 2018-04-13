//
//  Account+Helpers.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


extension Account {
    
    static let InvalidToken: NSNotification.Name = NSNotification.Name("InvalidAccountToken")
    
    var iconImage: UIImage {
        guard let data = icon, let image = UIImage(data: data) else {
            return UIImage.defaultIcon
        }
        return image
    }
    
    func reportInvalidAuthToken() throws {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Account.InvalidToken, object: self)
            self.token = nil
            try? self.save()
        }
    }
    
}
