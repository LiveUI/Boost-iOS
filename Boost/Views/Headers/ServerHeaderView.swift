//
//  ServerHeaderView.swift
//  Boost
//
//  Created by Ondrej Rafaj on 02/12/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Base
import Hagrid


class ServerHeaderView: GridTableViewHeaderFooterView {
    
    var account: Account? {
        didSet {
            guard let account = account else {
                return
            }
            titleLabel.text = account.name
            subtitleLabel.text = account.subtitle
        }
    }
    
    var didTapAccountsButton: (() -> ())?
    
    let iconMenuButton = Button()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let showAllButton = UIButton()
    
    // MARK: Elements
    
    override func setupElements() {
        super.setupElements()
        
        gridView.backgroundColor = UIColor(hex: "353C4B")
        gridView.config.automaticVerticalSizing = true
        gridView.config.padding = .full(top: 13, left: 14, right: 14, bottom: 13)
        
        iconMenuButton.layer.cornerRadius = 6
        iconMenuButton.clipsToBounds = true
        iconMenuButton.contentMode = .scaleAspectFit
        iconMenuButton.backgroundColor = .red
        iconMenuButton.layer.borderWidth = 0
        iconMenuButton.action = { button in
            self.didTapAccountsButton?()
        }
        gridView.add(subview: iconMenuButton, .toTop, from: 0, space: 2) { make in
            make.height.equalTo(self.iconMenuButton.snp.width)
        }
        
        titleLabel.font = Font.basic(size: 17)
        titleLabel.textColor = .white
        gridView.add(subview: titleLabel, 8, from: .relation(iconMenuButton, margin: 24))
        
        subtitleLabel.font = Font.basic(size: 12)
        subtitleLabel.textColor = UIColor(hex: "BAB5B5")
        gridView.add(subview: subtitleLabel, .below(titleLabel, margin: 4), from: .relation(iconMenuButton, margin: 24))
    }
    
}
