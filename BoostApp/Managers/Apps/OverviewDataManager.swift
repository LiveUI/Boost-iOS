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


class OverviewDataManager: PresentableCollectionViewDataManager, AppManager {
    
    var appDetailRequested: ((App)->())?
    var appActionRequested: ((App)->())?
    var allBuildsRequested: ((App)->())?
    var deleteAllRequested: ((App)->())?
    
    var selectedTags: [String] = []
    
    private var sectionCache: [Int: [App]] = [:]
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        setFakeOverview()
        loadOverview()
    }
    
    // MARK: Data
    
    private func setFakeOverview() {
        let section = PresentableSection()
        
        section.header = Presentable<AppHeader>.create()
        
        section.presentables.append(Presentable<AppCollectionViewCell>.create())
        section.presentables.append(Presentable<AppCollectionViewCell>.create())
        section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
        if device != .phone {
            section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
            section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
            section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
        }
        
        data.append(section)
    }
    
    private func present(overviews: [Overview]) {
        data.removeAll()
        
        var sectionIndex: Int = 0
        
        for overview in overviews {
            let section = PresentableSection()
            
            section.header = Presentable<AppHeader>.create({ header in
                header.titleLabel.text = overview.latestName
                header.subtitleLabel.text = overview.identifier
                header.versionLabel.text = "\(overview.latestVersion) (\(overview.latestBuild))"
            })
            
//            if let apps = sectionCache[sectionIndex] {
//
//            } else {
                section.presentables.append(Presentable<AppCollectionViewCell>.create())
                section.presentables.append(Presentable<AppCollectionViewCell>.create())
                if device != .phone {
                    section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                    section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                    section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                }
                
//            }
            data.append(section)
            
            sectionIndex += 1
        }
    }
    
    private func loadOverview() {
        do {
            try api?.overview().then({ data in
                self.present(overviews: data)
            })
        } catch {
             print(error)
        }
    }

    
}
