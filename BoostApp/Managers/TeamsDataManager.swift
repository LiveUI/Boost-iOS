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
            try api?.teams().then({ teams in
                // Add all teams selector
                let all = Presentable<GenericMenuTableViewCell>.create({ (cell) in
                    cell.icon.set(image: UIImage.defaultIcon)
                    cell.titleLabel.text = Lang.get("menu.teams.all")
                })
                section.presentables.append(all)
                
                // Show all teams
                for team in teams {
                    let presentable = Presentable<GenericMenuTableViewCell>.create({ (cell) in
                        cell.icon.set(initials: team.initials, bgColor: team.color.hexColor!)
                        cell.titleLabel.text = team.name
                    })
                    section.presentables.append(presentable)
                }
            }).error({ error in
                if let error = error as? Networking.Problem, error == .badToken {
                    try? self.account?.reportInvalidAuthToken()
                } else {
                    // TODO: Replace with generic loading problem cell!!!
                    let sort = Presentable<UITableViewCell>.create({ (cell) in
                        cell.textLabel?.text = Lang.get("menu.teams.error.loading_problem")
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

