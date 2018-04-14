//
//  TeamIconView.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Modular


class TeamIconView: UIView {
    
    
    private let initials = UILabel()
    private let icon = UIImageView()
    
    
    // MARK: Settings
    
    public func set(initials: String) {
        self.initials.text = initials.uppercased()
    }
    
    public func set(image: UIImage) {
        self.icon.image = image
    }
    
    // MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .lightGray
        
        layer.cornerRadius = 4
        clipsToBounds = true
        
        initials.font = UIFont.boldSystemFont(ofSize: 24)
        initials.textColor = .white
        initials.textAlignment = .center
        initials.place.on(andFill: self)
        
        icon.contentMode = .scaleAspectFill
        icon.place.on(andFill: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
