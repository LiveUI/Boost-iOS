//
//  HomeDataManagement.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK
import Presentables


class HomeDataManager: PresentableCollectionViewDataManager, AppsDataManagerable {
    
    var appDetailRequested: ((App)->())?
    var appActionRequested: ((App)->())?
    var allBuildsRequested: ((App)->())?
    var deleteAllRequested: ((App)->())?
    
    var selectedTags: [String] = []
    
    
    // MARK: Data
    
    func loadData() {
        func makePresenters(_ apps: [App]) {
            // Sort apps by their identifier
            let apps = apps.sorted { (app1, app2) -> Bool in
                app1.identifier < app2.identifier
            }
            
            // Split into separate arrays
            var result: [[App]] = []
            var previousIdentifier: String? = nil
            for app in apps {
                if app.identifier != previousIdentifier {
                    result.append([])
                    previousIdentifier = app.identifier
                }
                result[result.endIndex - 1].append(app)
            }
            
            // Sort arrays by name of first app
            result.sort { (arr1, arr2) -> Bool in
                arr1.first!.name < arr2.first!.name
            }

            // Create presenters
            for apps in result {
                let section = PresentableSection()
                
                // Create a section header
                let header = AppHeaderPresenter()
                header.configure = { presentable in
                    guard let header = presentable as? AppHeader else {  return }
                    header.titleLabel.text = "\(apps.first!.name) (\(apps.first!.identifier))"
                    header.didPressShowAll = {
                        self.allBuildsRequested?(apps.first!)
                    }
                    header.didPressDeleteAll = {
                        print("Delete all apps with identifier: \(apps.first!.identifier) on platform: \(apps.first!.platform)")
                        self.deleteAllRequested?(apps.first!)
                    }
                }
                section.header = header
                
                // And all the presenters
                for app in apps.sorted(by: { (app1, app2) -> Bool in
                    app1.created! < app2.created!
                }) {
                    let p = AppCollectionViewCellPresenter()
                    p.didSelectCell = {
                        self.appDetailRequested?(app)
                    }
                    p.configure = { presentable in
                        guard let cell = presentable as? AppCollectionViewCell else {  return }
                        cell.didTapActionButton = { sender in
                            self.appActionRequested?(app)
                        }
                        cell.nameLabel.text = app.name
                    }
                    section.presenters.append(p)
                }
                self.data.append(section)
            }
        }
        
        Boost.api.apps { (result) in
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
