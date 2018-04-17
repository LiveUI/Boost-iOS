//
//  AppFlowCoordinator.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 15/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class AppFlowCoordinator {
    
    var currentTeam: BaseCoordinator.ActiveTeam = .all {
        didSet {
            
        }
    }
    
    func entrypoint(account: Account, team: BaseCoordinator.ActiveTeam) -> ViewController {
        return OverviewViewController(account: account)
    }

}
