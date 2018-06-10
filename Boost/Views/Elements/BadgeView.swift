//
//  BadgeView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Base
import Modular


class BadgeView: UIView {
    
    enum Style {
        case none
        case danger
        case warning
        case info
    }
    
    private let label = UILabel()
    
    
    // MARK: Settings
    
    var value: String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = newValue
            label.sizeToFit()
        }
    }
    
    var style: Style {
        didSet {
            switch style {
            case .none:
                backgroundColor = .gray
                label.textColor = .white
            case .danger:
                backgroundColor = .red
                label.textColor = .white
            case .warning:
                backgroundColor = .orange
                label.textColor = .white
            case .info:
                backgroundColor = .blue
                label.textColor = .black
            }
        }
    }
    
    // MARK: Layout
    
    override func sizeToFit() {
        label.sizeToFit()
        super.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = (bounds.size.height / 2.0)
    }
    
    // MARK: Initialization
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        self.style = .none
        
        super.init(frame: CGRect.zero)
        
        clipsToBounds = true
        
        label.font = Font.basicBold(size: 13)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.place.on(self, top: 3, bottom: -3).sides(left: 4, right: -4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
