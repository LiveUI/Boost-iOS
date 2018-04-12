//
//  SelectedTagsDataManager.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 03/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import Presentables
import MaterialComponents


class SelectedTagsDataManager: PresentableCollectionViewDataManager, UICollectionViewDelegateFlowLayout {
    
    let section: PresentableSection

    var tags: [String] = [] {
        didSet {
            reloadTags()
        }
    }
    
    init(tags: [String] = []) {
        self.section = PresentableSection()
        
        super.init()
        
        self.tags = []
        
        section.presentables.append(Presentable<MDCChipCollectionViewCell>.create { cell in
            cell.chipView.titleLabel.text = "tag_huhuhu_1.2.3"
            cell.chipView.imageView.image = UIImage.defaultIcon
            cell.chipView.imageView.clipsToBounds = true
            cell.chipView.sizeToFit()
        })
        
        reloadTags()
        
        data.append(section)
    }
    
    private func reloadTags() {
        section.presentables.removeAll()
        for tag in tags {
            section.presentables.append(Presentable<MDCChipCollectionViewCell>.create { cell in
                cell.chipView.titleLabel.text = tag
                cell.chipView.imageView.image = UIImage.defaultIcon
                cell.chipView.sizeToFit()
            })
        }
    }
    
    // MARK: Collection view delegate & data source overrides
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 150, height: 44)
    }

}
