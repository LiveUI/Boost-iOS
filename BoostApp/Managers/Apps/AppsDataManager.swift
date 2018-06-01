//
//  AppsDataManager.swift
//  Boost
//
//  Created by Ondrej Rafaj on 30/11/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK
import Presentables


class AppsDataManager: PresentableCollectionViewDataManager, AppManager {
    
    var leadingApp: App? {
        didSet {
            if leadingApp != nil {
                loadData()
            }
        }
    }
    
    var appDetailRequested: ((App)->())?
    var appActionRequested: ((App)->())?
    
    var selectedTags: [String] = []
    
    
    // MARK: Initialization
    
    init(leadingApp: App? = nil) {
        self.leadingApp = leadingApp
        
        super.init()
    }
    
    // MARK: Data handling
    
    private func loadData() {
        func makePresenters(_ apps: [App]) {
            let section = PresentableSection()
            for app in apps {
                let presentable = Presentable<AppCollectionViewCell>.create { (cell) in
                    cell.didTapActionButton = { sender in
                        self.appActionRequested?(app)
                    }
                    cell.nameLabel.text = app.name
                }.cellSelected {
                    self.appDetailRequested?(app)
                }
                section.append(presentable)
            }
            data.append(section)
        }
    }
    
    // MARK: Collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 94)
    }
    
}
