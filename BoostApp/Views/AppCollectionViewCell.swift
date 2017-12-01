//
//  AppCollectionViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 01/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables


class AppCollectionViewCell: UICollectionViewCell, Presentable {
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class AppCollectionViewCellPresenter: SelectablePresenter {
    
    var presentable: Presentable.Type = AppCollectionViewCell.self
    
    var configure: ((Presentable) -> ())?
    
    var didSelectCell: (() -> ())?
    
}
