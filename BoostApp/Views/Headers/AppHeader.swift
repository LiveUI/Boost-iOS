//
//  AppHeader.swift
//  Boost
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import Modular


class AppHeader: UICollectionReusableView {
    
    var didPressDeleteAll: (()->())?
    
    let deleteAll = UIButton()
    
    let titleLabel = MainContentLabel()
    let subtitleLabel = SmallTextLabel()
    
    let versionLabel = SmallTextLabel()
    
    
    // MARK: Configure elements
    
    func configureElements() {
        backgroundColor = .white
        
        deleteAll.setTitleColor(Theme.default.primeButtonColor.hexColor, for: .normal)
        deleteAll.backgroundColor = Theme.default.primeButtonBackgroundColor.hexColor
        deleteAll.setTitle(Lang.get("apps.header.delete_all"), for: .normal)
        deleteAll.addTarget(self, action: #selector(didPressDeleteAll(_:)), for: .touchUpInside)
        deleteAll.place.on(self).with.leftMargin().topMargin().width(60).and.height(24)
        
        versionLabel.textAlignment = .right
        versionLabel.place.on(self).with.rightMargin().topMargin()
        
        titleLabel.textAlignment = .center
        titleLabel.place.between(deleteAll, and: versionLabel, height: 24).topMargin(8)
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.place.below(titleLabel, top: 10).match(left: titleLabel).match(right: titleLabel)
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func didPressDeleteAll(_ sender: UIButton) {
        didPressDeleteAll?()
    }
    
}

