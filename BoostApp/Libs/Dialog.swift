//
//  Dialog.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialDialogs


class Dialog {
    
    static func show(warning title: String? = nil, message: String, on viewController: UIViewController) {
        let alert = MDCAlertController(title: title, message: message)
        let action = MDCAlertAction(title: Lang.get("general.ok"))
        alert.addAction(action)
        
        viewController.present(alert, animated:true)    
    }
    
    static func show(error: Error, on viewController: UIViewController) {
        show(warning: Lang.get("general.error"), message: error.localizedDescription, on: viewController)
    }
    
    static func show(confirmation title: String? = nil, message: String, on viewController: UIViewController, _ result: @escaping ((_ confirmed: Bool) -> Void)) {
        let alert = MDCAlertController(title: title, message: message)
        let actionYes = MDCAlertAction(title: Lang.get("general.yes")) { (action) in
            result(true)
        }
        alert.addAction(actionYes)
        let actionNo = MDCAlertAction(title: Lang.get("general.no")) { (action) in
            result(false)
        }
        alert.addAction(actionNo)

        viewController.present(alert, animated:true)
    }
    
}
