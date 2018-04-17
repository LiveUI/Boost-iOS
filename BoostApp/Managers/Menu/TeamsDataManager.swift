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
    var teamCounts: [UUID: String] = [:]
    
    var teamsChanged: (()->())?
    
    func loadData() {
        // Reset
        data.removeAll()
        teamCounts = [:]
        
        let section = PresentableSection()
        
        // Display loading cell
        let loading = Presentable<MenuLoadingTableViewCell>.create()
        section.presentables.append(loading)
        
        // Fetch teams
        do {
            try api?.teams().then({ teams in
                section.presentables.removeAll() // Remove loading
                
                // Add all teams selector
                let all = Presentable<GenericMenuTableViewCell>.create({ (cell) in
                    cell.icon.set(image: UIImage.defaultIcon)
                    cell.titleLabel.text = Lang.get("menu.teams.all")
                    cell.selectedIndicator.isHidden = !self.appFlowCoordinator.currentTeam.isAll
                }).cellSelected {
                    self.appFlowCoordinator.currentTeam = .all
                }
                section.presentables.append(all)
                
                // Show all teams
                for team in teams {
                    let presentable = Presentable<TeamsTableViewCell>.create({ (cell) in
                        cell.icon.set(initials: team.initials, bgColor: team.color.hexColor!)
                        cell.titleLabel.text = team.name
                        cell.badge.value = self.teamCounts[team.id!] ?? "..."
                        cell.selectedIndicator.isHidden = !(team == self.appFlowCoordinator.currentTeam.team)
                        
                        // Load info
                        // TODO: Enable later when API works! :)
//                        _ = try? self.api?.info(team: team.id!).then({ info in
//                            cell.badge.value = String(info.apps)
//                        })
                    }).cellSelected {
                        self.appFlowCoordinator.currentTeam = .specific(team)
                    }
                    section.presentables.append(presentable)
                }
            }).error({ error in
                if let error = error as? Networking.Problem, error == .badToken {
                    try? self.account?.reportInvalidAuthToken()
                } else {
                    // TODO: Replace with generic loading problem cell!!!
                    let presentable = Presentable<UITableViewCell>.create({ (cell) in
                        cell.textLabel?.text = Lang.get("menu.teams.error.loading_problem")
                    })
                    section.presentables.append(presentable)
                }
            })
        } catch {
            // TODO: Handle! How? :/
            print(error)
        }
        
        data.append(section)
    }
    
    override init() {
        super.init()
        
        selectedCell = { info in
            info.tableView.deselectRow(at: info.indexPath, animated: true)
            info.tableView.reloadData()
        }
    }
    
}

