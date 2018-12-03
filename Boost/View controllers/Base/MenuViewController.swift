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
    
    var api: Api!
    
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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.isTranslucent = false
        
        presentableManager.selectedCell = { info in
            info.tableView.deselectRow(at: info.indexPath, animated: true)
            self.dismiss(animated: true)
        }
    }
    
    // MARK: Data
    
    override func setupData() {
        super.setupData()
        
        let section = PresentableSection()
        section.header = Presentable<ServerHeaderView>.create({ header in
            guard let account = self.baseCoordinator.currentAccount else {
                return
            }
            header.titleLabel.text = account.name
            header.subtitleLabel.text = account.subtitle ?? account.server ?? "n/a"
            
            header.didTapAccountsButton = {
                self.dismiss(animated: true, completion: {
                    self.baseCoordinator.requestAccountsList()
                })
            }
        })
        
        do {
            try api.teams().then({ teams in
                let allCell = Presentable<TeamTableViewCell>.create({ cell in
                    cell.icon.backgroundColor = .blue
                    cell.icon.image = Awesome.Solid.objectGroup.asImage(size: 26, color: .white)
                    cell.nameLabel.text = "All teams"
                    cell.subtitleLabel.text = "Loading ..."
                })
                section.append(allCell)
                
                for team in teams {
                    let p = Presentable<TeamTableViewCell>.create({ cell in
                        cell.team = team
                    })
                    section.append(p)
                }
            })
        } catch {
            
        }
        
        data.append(section)
    }
    
}
