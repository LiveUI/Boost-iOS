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


class AppsDataManager: PresentableCollectionViewDataManager {
    
    var appDetailRequested: ((App)->())?
    var appActionRequested: ((App)->())?
    
    var apps: [App] = []
    
    func loadData() {
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
        data.append(presenters.section)
    }
    
    // MARK: Collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 94)
    }
    
}
