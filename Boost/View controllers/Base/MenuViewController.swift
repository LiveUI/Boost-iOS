//
//  MenuViewController.swift
//  Boost
//
//  Created by Ondrej Rafaj on 10/11/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Base
import UIKit
import BoostSDK
import AwesomeEnum


class MenuViewController: TableViewController {
    
    var account: Account!
    var api: Api!
    
    var refresh = UIRefreshControl()
    
    override func setupElements() {
        super.setupElements()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let top = UIView()
        top.backgroundColor = UIColor(hex: "353C4B")
        top.place.on(andFill: tableView, top: -500, left: 0).height(530).match(width: tableView)
        
        view.backgroundColor = UIColor(hex: "353C4B")
        tableView.backgroundColor = UIColor(hex: "404654")
        tableView.separatorStyle = .none
        
        tableView.alwaysBounceVertical = true
        refresh.tintColor = .lightGray
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refresh)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.isTranslucent = false
        
        presentableManager.selectedCell = { info in
            info.tableView.deselectRow(at: info.indexPath, animated: true)
            self.dismiss(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupData()
    }
    
    // MARK: Data
    
    lazy var mainHeader: Presentable<ServerHeaderView> = {
        Presentable<ServerHeaderView>.create({ header in
            guard let account = self.baseCoordinator.currentAccount else {
                return
            }
            header.titleLabel.text = account.name
            header.subtitleLabel.text = account.subtitle ?? account.server ?? "n/a"
            
            if let iconData = account.icon, let icon = UIImage(data: iconData) {
                header.iconMenuButton.setImage(icon, for: .normal)
            } else {
                header.iconMenuButton.setImage(UIImage.defaultIcon, for: .normal)
            }
            
            header.didTapAccountsButton = {
                self.dismiss(animated: true, completion: {
                    self.baseCoordinator.requestAccountsList()
                })
            }
        })
    }()
    
    var totalLoaded = false
    var totalAppsCount = 0
    var totalBuildsCount = 0
    
    override func setupData() {
        super.setupData()
        
        guard data.count == 0 else {
            return
        }
        
        totalLoaded = false
        totalAppsCount = 0
        totalBuildsCount = 0
        
        let section = PresentableSection()
        section.header = mainHeader
        
        do {
            try api.teams().then({ teams in
                let allCell = Presentable<TeamTableViewCell>.create({ cell in
                    cell.icon.backgroundColor = .orange
                    cell.icon.image = Awesome.Solid.layerGroup.asImage(size: 26, color: .white)
                    cell.icon.contentMode = .center
                    
                    cell.nameLabel.text = "All teams"
                    cell.subtitleLabel.text = self.totalLoaded ?  "\(self.totalAppsCount) apps, \(self.totalBuildsCount) builds" : "Loading ..."
                })
                section.append(allCell)
                
                for team in teams {
                    guard let teamId = team.id else {
                        // QUESTION: Do we want to display team anyway with some default data?
                        return
                    }
                    try self.api.info(team: teamId).then({ info in
                        self.totalLoaded = true
                        self.totalAppsCount += info.apps
                        self.totalBuildsCount += info.builds
                        
                        let p = Presentable<TeamTableViewCell>.create({ cell in
                            cell.icon.backgroundColor = .clear
                            cell.icon.contentMode = .scaleAspectFit
                            cell.team = team
                            cell.info = info
                        })
                        section.append(p)
                    })
                }
            })
        } catch {
            
        }
        
        data = [section]
    }
    
    // MARK: Actions
    
    @objc func refreshData() {
        data = [] // Reset the data so it loads again
        
        setupData()
        refresh.endRefreshing()
    }
    
}
