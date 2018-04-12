//
//  TeamsDataManager.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 12/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import BoostSDK


class TeamsDataManager: PresentableTableViewDataManager {
    
    var teams: [Team] = []
    
    var teamsChanged: (()->())?
    
    func loadData() {
        let section = PresentableSection()
        
        let sort = Presentable<TeamTableViewCell>.create({ (cell) in
            cell.textLabel?.text = "Team Yo!"
        })
        section.presentables.append(sort)
        
        data.append(section)
    }
    
}

