//
//  FakeAppHeader.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 16/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


class FakeAppHeader: AppHeader {
    
    override func configureElements() {
        super.configureElements()
        
//        deleteAll.setTitle(nil, for: .normal)
        deleteAll.backgroundColor = .lightGray
        
//        versionLabel.text = " "
        versionLabel.backgroundColor = .lightGray
        
//        titleLabel.text = " "
        titleLabel.backgroundColor = .lightGray
        
//        subtitleLabel.text = " "
        subtitleLabel.backgroundColor = .lightGray
    }
    
}
