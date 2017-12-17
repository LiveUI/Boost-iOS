//
//  AppsDataManager.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 30/11/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK
import Presentables


protocol AppsDataManagerable: CollectionViewPresentableManager {
    var appDetailRequested: ((App)->())? { get set }
    var appActionRequested: ((App)->())? { get set }
    func loadData()
    var selectedTags: [String] { get set }
}


class AppsDataManager: PresentableCollectionViewDataManager, AppsDataManagerable {
    
    let leadingApp: App
    
    var appDetailRequested: ((App)->())?
    var appActionRequested: ((App)->())?
    
    var selectedTags: [String] = []
    
    
    // MARK: Initialization
    
    init(leadingApp: App) {
        self.leadingApp = leadingApp
        
        super.init()
    }
    
    // MARK: Data handling
    
    func loadData() {
        func makePresenters(_ apps: [App]) {
            var presenters: [Presenter] = []
            for app in apps {
                let p = AppCollectionViewCellPresenter()
                p.didSelectCell = {
                    self.appDetailRequested?(app)
                }
                p.configure = { presentable in
                    guard let cell = presentable as? AppCollectionViewCell else {
                        return
                    }
                    cell.didTapActionButton = { sender in
                        self.appActionRequested?(app)
                    }
                    cell.nameLabel.text = app.name
                }
                presenters.append(p)
            }
            self.data.append(presenters.section)
        }
        
        Boost.api.apps(identifier: leadingApp.identifier, platform: leadingApp.platform) { (result) in
            print(result)
            
            switch result {
            case .success(let apps):
                makePresenters(apps)
            case .error(let error):
                print(error?.localizedDescription ?? "API Error")
            }
        }
    }
    
    // MARK: Collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 94)
    }
    
}
