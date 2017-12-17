//
//  SortTableViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables


class SortTableViewCell: UITableViewCell, Presentable {
    
}


class SortTableViewCellPresenter: SelectablePresenter {
    
    var didSelectCell: (() -> ())?
    
    var presentable: Presentable.Type = SortTableViewCell.self
    
    var configure: ((Presentable) -> ())?
    
}
