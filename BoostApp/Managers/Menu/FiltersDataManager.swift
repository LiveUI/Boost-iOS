//
//  FiltersDataManager.swift
//  Boost
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import Presentables


class FiltersDataManager: PresentableTableViewDataManager {
    
    var selectedTags: [String] = [] {
        didSet {
//            tableView?.reloadData()
        }
    }
    var tagsChanged: (()->())?
    
    func loadData() {
        let section = PresentableSection()
        
        let sort = Presentable<SortTableViewCell>.create({ (cell) in
            cell.textLabel?.text = "Sorting"
        })
        section.append(sort)
        
        let tags: [String] = ["Version_1.2.0", "Another tag", "this is dope!", "Lorem", "ipsum", "dolor", "sit", "amet", "rectum", "dolae", "woe"]
        
        for tag in tags {
            let filter = Presentable<FilterTableViewCell>.create({ (cell) in
                cell.textLabel?.text = tag
                cell.detailTextLabel?.text = "1981"
            }).cellSelected {
                if self.selectedTags.contains(tag) {
                    guard let index = self.selectedTags.index(of: tag) else { return }
                    self.selectedTags.remove(at: index)
                }
                else {
                    self.selectedTags.append(tag)
                }
                self.tagsChanged?()
            }
            section.append(filter)
        }
        
        data.append(section)
    }
    
    // MARK: Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
