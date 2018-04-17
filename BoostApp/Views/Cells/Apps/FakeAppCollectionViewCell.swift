//
//  FakeAppCollectionViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 09/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AwesomeEnum


class FakeAppCollectionViewCell: AppCollectionViewCell {
    
    override func configureElements() {
        super.configureElements()
        
        let color = UIColor.lightGray
        
        iconView.backgroundColor = color
        
        nameLabel.text = " "
        nameLabel.backgroundColor = color
        
        uploadedLabel.text = " "
        uploadedLabel.backgroundColor = color
        
        infoLabel.text = " "
        infoLabel.backgroundColor = color
        
        installButton.setImage(nil, for: .normal)
        installButton.backgroundColor = color
    }
    
}
