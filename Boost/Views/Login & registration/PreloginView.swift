//
//  PreloginView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 04/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Base


class PreloginView: View {
    
    var selected: ((Config, server: String?))?
    
    enum Config {
        case login
        case github
        case register
    }
    
    let elements: [Config]
    let server: String?
    
    // MARK: Initialization
    
    init(_ elements: [Config], server: String) {
        self.elements = elements
        self.server = server
        
        super.init()
    }
    
    convenience init(_ elements: [Config], server: Bool) {
        self.init(elements, server: "")
    }
    
    // MARK: Elements
    
    override func setupElements() {
        super.setupElements()
        
        
    }
    
}
