//
//  Coordinator.swift
//  LiveUIBase
//
//  Created by Ondrej Rafaj on 28/05/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

@_exported import Foundation
@_exported import UIKit
import Base


/// Coordinator take off tuple
public typealias CoordinatorTakeOffTuple = (viewController: UIViewController, presentation: Presentation)


/// Coordinator protocol
public protocol Coordinator {
    
    /// Current view controller
    var currentViewController: UIViewController? { get set }
    
    /// Launch coordinator on a view controller
    @discardableResult func takeOff(in: CoordinatorTakeOffTuple?) -> UIViewController
    
}


extension Coordinator {
    
    /// Present view controller
    public func present(_ viewController: UIViewController, in parent: UIViewController, presentation: Presentation = .present) {
        presentation.setModalAttributes(on: viewController)
        
        switch presentation {
        case .push:
            parent.navigationController?.pushViewController(viewController, animated: true)
        default:
            parent.present(viewController, animated: presentation.animated)
        }
    }
    
    /// Close view controller
    public func close(_ viewController: UIViewController, animated: Bool = true) {
        if viewController.isModal() {
            viewController.dismiss(animated: animated)
        } else {
            viewController.navigationController?.popViewController(animated: animated)
        }
    }
    
}
