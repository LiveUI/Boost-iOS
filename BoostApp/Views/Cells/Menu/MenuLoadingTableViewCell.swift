//
//  MenuLoadingTableViewCell.swift
//  Boost
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import AwesomeEnum
import Modular


class MenuLoadingTableViewCell: MenuTableViewCell {
    
    let loadingView = UIImageView()
    
    
    // MARK: Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        let side: CGFloat = 24.0
        loadingView.image = Awesome.solid.spinner.asImage(size: side, color: .white)
        loadingView.animateLoadingSpinner()
        loadingView.place.on(contentView, width: side).center().topMargin(20).minBottomMargin(-20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
