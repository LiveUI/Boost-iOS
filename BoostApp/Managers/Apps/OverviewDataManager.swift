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
        
        section.header = Presentable<FakeAppHeader>.create()
        
        section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
        section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
        if device != .phone {
            section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
            section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
            section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
            section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
        }
        
        data.append(section)
    }
    
    private func present(apps: [App], on section: inout PresentableSection) {
        section.presentables.removeAll()
        for app in apps {
            let presentable = Presentable<AppCollectionViewCell>.create({ cell in
                cell.nameLabel.backgroundColor = .red
                cell.nameLabel.text = app.name
                cell.uploadedLabel.text = "\(app.created!)"
                cell.iconView.image = UIImage.defaultIcon
            })
            section.presentables.append(presentable)
        }
        section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
        section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
        section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
    }
    
    private func present(overviews: [Overview]) {
        data.removeAll()
        
        var sectionIndex: Int = 0
        
        for overview in overviews {
            var section = PresentableSection()
            
            section.header = Presentable<AppHeader>.create({ header in
                header.titleLabel.text = overview.latestName
                header.subtitleLabel.text = overview.identifier
                header.versionLabel.text = "\(overview.latestVersion) (\(overview.latestBuild))"
                header.versionLabel.sizeToFit()
                
                if let apps = self.sectionCache[sectionIndex] {
                    self.present(apps: apps, on: &section)
                } else {
                    do {
                        try self.api?.apps(platform: overview.platform, identifier: overview.identifier, limit: 5).then({ apps in
                            self.sectionCache[sectionIndex] = apps
                            DispatchQueue.main.async {
                                self.present(apps: apps, on: &section)
                                self.reload(section: sectionIndex)
                            }
                        })
                    } catch {
                        // TODO: Display error loading cell
                    }
                }
            })
            
            if let apps = sectionCache[sectionIndex] {
                present(apps: apps, on: &section)
                reload(section: sectionIndex)
            } else {
                section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                if device != .phone {
                    section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                    section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                    section.presentables.append(Presentable<FakeAppCollectionViewCell>.create())
                }
                
            }
            data.append(section)
            
            sectionIndex += 1
        }
    }
    
    private func loadOverview() {
        do {
            try api?.overview().then({ data in
                DispatchQueue.main.async {
                    self.present(overviews: data)
                }
            })
        } catch {
             print(error)
        }
    }

    
}
