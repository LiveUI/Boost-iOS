//
//  OverviewDataManager.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK


class OverviewDataManager: PresentableCollectionViewDataManager {
    
    var account: Account
    
    var appDetailRequested: ((App)->())?
    var appActionRequested: ((App)->())?
    var allBuildsRequested: ((App)->())?
    var deleteAllRequested: ((App)->())?
    
    var selectedTags: [String] = []
    
    
    // MARK: Initialization
    
    init(account: Account) {
        self.account = account
        
        super.init()
        
        setFakeOverview()
        loadOverview()
    }
    
    // MARK: Data
    
    func setFakeOverview() {
        // TODO: Load fake app with fake fields
    }
    
    func loadOverview() {
        do {
            try api?.overview().then({ apps in
                print(apps)
            })
        } catch {
            print(error)
        }
    }
    
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
                let header = Presentable<AppHeader>.create { (header) in
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
                    let presentable = Presentable<AppCollectionViewCell>.create { (cell) in
                        cell.didTapActionButton = { sender in
                            self.appActionRequested?(app)
                        }
                        cell.nameLabel.text = app.name
                    }.cellSelected {
                        self.appDetailRequested?(app)
                    }
                    section.presentables.append(presentable)
                }
                self.data.append(section)
            }
        }
    }
    
    // MARK: Collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 94)
    }
    
}