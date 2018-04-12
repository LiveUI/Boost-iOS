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
        
        do {
            try account?.api().teams().then({ teams in
                let section = PresentableSection()
                
                for team in teams {
                    let sort = Presentable<TeamTableViewCell>.create({ (cell) in
                        cell.textLabel?.text = team.name
                    })
                    section.presentables.append(sort)
                }
                
                self.data.append(section)
            })
        } catch {
//            Dialog.show(error: error, on: self)
        }
    }
    
}

