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
            try api.overview(platform: .ios, from: 0, limit: 200).then({ overview in
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
                    cell.label.text = overview.latestName
                })
            }))
            DispatchQueue.main.async {
                self.data = [section]
            }
        }
    }
    
}
