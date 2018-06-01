//
//  LayoutViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 29/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular
//import SnapKit


class LayoutViewController: UIViewController {
    
    let leftScreen = LeftMenuViewController()
    lazy var shadow: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapShadow(_:)))
        v.addGestureRecognizer(tap)
        
        return v
    }()
    var currentScreen: UIViewController?
    
    
    // MARK: Left menu
    
    func calculateMenuWidth(_ width: CGFloat? = nil) -> CGFloat {
        let screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        let maxWidth = min((screenWidth - 34), 400)
        let w = ((width ?? view.frame.size.width) - 44)
        let cw = ((w < 278) ? 278 : w)
        let menuWidth: CGFloat = (cw > maxWidth) ? maxWidth : cw
        return menuWidth
    }

    
    // MARK: Controls
    
    func showMenu() {
        shadow.isHidden = false
        shadow.alpha = 1
        leftScreen.view.snp.remakeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(self.calculateMenuWidth())
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func hideMenu(isAnimating: Bool = false) {
        shadow.alpha = 0
        if !isAnimating {
            shadow.isHidden = true
        }
        let w = self.calculateMenuWidth()
        leftScreen.view.snp.remakeConstraints { make in
            make.left.equalTo(-w)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(w)
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func showMenu(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.showMenu()
            }, completion: nil)
        } else {
            showMenu()
        }
    }
    
    func hideMenu(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.hideMenu(isAnimating: true)
            }, completion: { _ in
                self.shadow.isHidden = true
            })
        } else {
            hideMenu()
        }
    }
    
    // MARK: Navigation
    
    func show(content: UIViewController, inNavigationViewController: Bool = true) {
        currentScreen = content
        
        // Remove previous screen
        if let currentScreen = currentScreen {
            currentScreen.view.removeFromSuperview()
            if let navigationController = currentScreen.navigationController {
                navigationController.removeFromParentViewController()
            } else {
                currentScreen.removeFromParentViewController()
            }
        }
        
        // Does new screen need a navigation controller?
        let displayViewController: UIViewController
        if inNavigationViewController {
            displayViewController = UINavigationController(rootViewController: content)
        } else {
            displayViewController = content
        }
        
        // Display new screen
        addChildViewController(displayViewController)
        displayViewController.view.place.on(andFill: view)
        displayViewController.didMove(toParentViewController: self)
        
        // Make sure menu & shadow are on the top
        view.bringSubview(toFront: shadow)
        view.bringSubview(toFront: leftScreen.view)
    }
    
    // MARK: Actions
    
    @objc func didTapShadow(_ sender: UITapGestureRecognizer) {
        hideMenu(animated: true)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add shadow
        shadow.place.on(andFill: view)
        
        // Add left menu
        addChildViewController(leftScreen)
        view.addSubview(leftScreen.view)
        leftScreen.didMove(toParentViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideMenu()
    }
    
}
