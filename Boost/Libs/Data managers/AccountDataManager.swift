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


class AccountDataManager: PresentableCollectionViewDataManager {
    
    /// Collection view layout
    lazy var layout: AppLayout = {
        let layout = AppLayout()
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
    
    /// Load apps
    private func getApps() {
        do {
            try api.apps(platform: .ios, identifier: "").then({ apps in
//                self.makePresentables(apps)
            }).error({ error in
                DispatchQueue.main.async {
                    self.feedback(error)
                }
            })
        } catch {
            
        }
    }
    
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
        let section = PresentableSection()
        section.append(Presentable<AppLoadingCell>.create())
        data.append(section)
    }
        
    /// MAke presentables from apps
    private func makePresentables(_ apps: [Overview]) {
        DispatchQueue.global().async {
            let section = PresentableSection()
            section.set(apps.map({ overview -> AnyPresentable in
                return Presentable<AppCell>.create({ cell in
                    cell.titleLabel.text = overview.latestName
                    cell.versionLabel.text = "\(overview.latestVersion) (\(overview.latestBuild))"
                    cell.iconImage.image = UIImage.defaultIcon
                    cell.actionButton.action = { sender in
                        sender.isEnabled = false
                        do {
                            try self.api.auth(app: overview.latestAppId).then({ appAuth in
                                print(appAuth)
                                DispatchQueue.main.async {
                                    sender.isEnabled = true
                                    guard let url = URL(string: appAuth.plist) else { return }
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            })
                        } catch {
                            sender.isEnabled = true
                        }
                    }
                })
            }))
            DispatchQueue.main.async {
                self.data = [section]
                self.layout.display = .apps
            }
        }
    }
    
}
