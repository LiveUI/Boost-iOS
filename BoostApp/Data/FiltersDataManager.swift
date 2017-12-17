//
//  FiltersDataManager.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import Presentables


class FiltersDataManager: PresentableTableViewDataManager {
    
    var selectedTags: [String] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    var tagsChanged: (()->())?
    
    func loadData() {
        var presenters: [Presenter] = []
        
        let sort = SortTableViewCellPresenter()
        sort.configure = { presentable in
            guard let cell = presentable as? SortTableViewCell else { return }
            cell.textLabel?.text = "Sorting"
        }
        presenters.append(sort)
        
        let tags: [String] = ["Version_1.2.0", "Another tag", "this is dope!", "Lorem", "ipsum", "dolor", "sit", "amet", "rectum", "dolae", "woe"]
        
        for tag in tags {
            let filter = FilterTableViewCellPresenter()
            filter.configure = { presentable in
                guard let cell = presentable as? FilterTableViewCell else { return }
                cell.textLabel?.text = tag
                cell.detailTextLabel?.text = "1981"
            }
            filter.didSelectCell = {
                if self.selectedTags.contains(tag) {
                    guard let index = self.selectedTags.index(of: tag) else { return }
                    self.selectedTags.remove(at: index)
                }
                else {
                    self.selectedTags.append(tag)
                }
                self.tagsChanged?()
            }
            presenters.append(filter)
        }
        
        data = [presenters.section]
    }
    
    // MARK: Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
