//
//  IconView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 13/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import Modular


class IconView: UIView {
    
    
    private let initials = UILabel()
    private let icon = UIImageView()
    
    
    // MARK: Settings
    
    public func set(initials: String, bgColor: UIColor) {
        self.initials.text = initials.uppercased()
        self.initials.textColor = bgColor.isDark ? .white : .black
        
        backgroundColor = bgColor
    }
    
    public func set(image: UIImage) {
        icon.image = image
    }
    
    public var imageContentMode: UIViewContentMode {
        get {
            return icon.contentMode
        }
        set {
            icon.contentMode = newValue
        }
    }
    
    // MARK: Initialization
    
    init() {
        super.init(frame: CGRect.zero)
        
        layer.cornerRadius = 4
        clipsToBounds = true
        
        initials.font = Font.basicBold(size: 18)
        initials.textAlignment = .center
        initials.place.on(andFill: self)
        
        icon.contentMode = .scaleAspectFill
        icon.place.on(andFill: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
