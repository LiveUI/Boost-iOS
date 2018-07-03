//
//  BuildsDataManager.swift
//  Boost
//
//  Created by Ondrej Rafaj on 03/07/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK


class BuildsDataManager: PresentableCollectionViewDataManager {
    
    /// Collection view layout
    lazy var layout: BuildsLayout = {
        let layout = BuildsLayout()
        return layout
    }()
    
    /// Feedback closure
    typealias FeedbackClosure = ((Api.Error) -> Void)
    
    /// Api
    let api: Api
    
    /// Overview
    let overview: Overview
    
    /// Feedback closure
    let feedback: FeedbackClosure
    
    /// Initializer
    init(_ api: Api, overview: Overview, _ feedback: @escaping FeedbackClosure) {
        self.api = api
        self.overview = overview
        
        self.feedback = feedback
        
        super.init()
        
        loadPreloadData()
    }
    
    /// Start loading data
    func startLoadingData() {
        getBuilds()
    }
    
    /// Load apps
    private func getBuilds() {
        do {
            try api.apps(platform: overview.platform, identifier: overview.identifier).then({ apps in
                self.makePresentables(apps)
            }).error({ error in
                DispatchQueue.main.async {
                    self.feedback(error)
                }
            })
        } catch {
            // TODO: Handle error!!
        }
    }
    
    // MARK: Private interface
    
    /// Load preload data
    private func loadPreloadData() {
        let section = PresentableSection()
        section.append(Presentable<AppLoadingCell>.create())
        data.append(section)
    }
    
    /// MAke presentables from apps
    private func makePresentables(_ builds: [App]) {
        DispatchQueue.global().async {
            let section = PresentableSection()
            section.set(builds.map({ app -> AnyPresentable in
                return Presentable<BuildCell>.create({ cell in
                    cell.titleLabel.text = "Uploaded: \(app.created)"
                    cell.versionLabel.text = "Version: \(app.version) (\(app.build))"
                    cell.iconImage.image = UIImage.defaultIcon
                    cell.actionButton.action = { sender in
                        sender.isEnabled = false
                        do {
                            try app.id?.download(app: self.api, finished: {
                                sender.isEnabled = true
                            })
                        } catch {
                            sender.isEnabled = true
                        }
                    }
                })
            }))
            DispatchQueue.main.async {
                self.data = [section]
                self.layout.invalidateLayout()
            }
        }
    }
    
}
