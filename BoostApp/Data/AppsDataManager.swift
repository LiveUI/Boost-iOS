//
//  AppsDataManager.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 30/11/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import Presentables


class AppsDataManager: PresentableCollectionViewDataManager {
    
    func loadData() {
        var apps: [Presenter] = []
        apps.append(AppCollectionViewCellPresenter())
        apps.append(AppCollectionViewCellPresenter())
        apps.append(AppCollectionViewCellPresenter())
        data.append(apps.section)
    }
    
}
