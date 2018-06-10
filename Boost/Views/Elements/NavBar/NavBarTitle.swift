//
//  NavBarTitle.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Base


class NavBarTitle: View {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override func setupElements() {
        titleLabel.place.on(self, top: 0)
    }
    
}
