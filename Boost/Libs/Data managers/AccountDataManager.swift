//
//  AccountsListDataManager.swift
//  Boost
//
//  Created by Ondrej Rafaj on 20/06/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK
import collection_view_layouts


class AccountDataManager: PresentableCollectionViewDataManager, ContentDynamicLayoutDelegate {
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 178)
    }
    
    var viewSize: CGSize = CGSize(width: 320, height: 568) {
        didSet {
            layout.columnsCount = Int(floor(viewSize.width / 178))
            layout.invalidateLayout()
        }
    }
    
    /// Collection view layout
    lazy var layout: PinterestStyleFlowLayout = {
        let layout = PinterestStyleFlowLayout()
        layout.delegate = self
//        layout.numberOfApps = {
//            return self.data[0].count
//        }
        layout.contentPadding = ItemsPadding(horizontal: 10, vertical: 10)
        layout.cellsPadding = ItemsPadding(horizontal: 8, vertical: 8)
        layout.contentAlign = .left
        layout.columnsCount = 3
        return layout
    }()
    
    /// Feedback closure
    typealias FeedbackClosure = ((Api.Error) -> Void)
    
    /// Account
    let account: Account
    
    /// Api
    let api: Api
    
    /// Feedback closure
    let feedback: FeedbackClosure
    
    /// Initializer
    init(_ account: Account, _ feedback: @escaping FeedbackClosure) {
        self.account = account
        api = account.api()
        
        self.feedback = feedback
        
        super.init()
        
        loadPreloadData()
    }
    
    /// Start loading data
    func startLoadingData() {
        getOverview()
    }
    
//    /// Load apps
//    private func getApps() {
//        do {
//            try api.apps(platform: .ios, identifier: "").then({ apps in
////                self.makePresentables(apps)
//            }).error({ error in
//                DispatchQueue.main.async {
//                    self.feedback(error)
//                }
//            })
//        } catch {
//            
//        }
//    }
    
    /// Load apps
    private func getOverview() {
        do {
            try api.overview(platform: .ios, from: 0, limit: 2000).then({ overview in
                self.makePresentables(overview)
            }).error({ error in
                DispatchQueue.main.async {
                    self.feedback(error)
                }
            })
        } catch {

        }
    }
    
    // MARK: Private interface
    
    /// Load preload data
    private func loadPreloadData() {
//        let section = PresentableSection()
//        section.append(Presentable<AppLoadingCell>.create())
//        data.append(section)
    }
        
    /// MAke presentables from apps
    private func makePresentables(_ apps: [Overview]) {
        DispatchQueue.global().async {
            let section = PresentableSection()
            
            section.header = Presentable<AppsHeaderView>.create({ view in
                
            })
            
            section.set(apps.map({ overview -> AnyPresentable in
                return Presentable<AppCell>.create({ cell in
                    cell.titleLabel.text = overview.latestName
                    cell.versionLabel.text = "\(overview.latestVersion) (\(overview.latestBuild))"
                    cell.iconImage.image = UIImage.defaultIcon
                    cell.actionButton.action = { sender in
                        sender.isEnabled = false
                        do {
                            try overview.latestAppId.download(app: self.api, finished: {
                                sender.isEnabled = true
                            })
                        } catch {
                            sender.isEnabled = true
                        }
                    }
                }).cellSelected {
                    self.baseCoordinator.requestBuilds(for: overview, api: self.api)
                }
            }))
            DispatchQueue.main.async {
                self.data = [section]
//                self.layout.display = .apps
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 60, bottom: 90, right: 10)
    }
    
}
