//
//  ViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 30/11/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var reportViewDidLoad: (() -> Void)?
    
    func configureElements() {
        
    }
    
    
    // MARK: View lifecycle
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureElements()
        
        reportViewDidLoad?()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

