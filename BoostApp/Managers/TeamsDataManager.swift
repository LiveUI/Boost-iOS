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
    
    var account: Account? {
        didSet {
            loadData()
        }
    }
    
    var teams: [Team] = []
    
    var teamsChanged: (()->())?
    
    func loadData() {
        data.removeAll()
        
        let section = PresentableSection()
        
        do {
            try account?.api().teams().then({ teams in
                let sort = Presentable<TeamTableViewCell>.create({ (cell) in
                    cell.textLabel?.text = Lang.get("teams.all")
                })
                section.presentables.append(sort)
                
                for team in teams {
                    let sort = Presentable<TeamTableViewCell>.create({ (cell) in
                        cell.textLabel?.text = team.name
                    })
                    section.presentables.append(sort)
                }
            }).error({ error in
                if let error = error as? Networking.Problem, error == .badToken {
                    try? self.account?.reportInvalidAuthToken()
                } else {
                    // TODO: Replace with generic loading problem cell!!!
                    let sort = Presentable<UITableViewCell>.create({ (cell) in
                        cell.textLabel?.text = Lang.get("teams.error.loading_problem")
                    })
                    section.presentables.append(sort)
                }
            })
        } catch {
            print(error)
        }
        
        data.append(section)
    }
    
}

