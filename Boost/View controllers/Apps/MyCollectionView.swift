//
//  MyCollectionView.swift
//  Xxxxxxx
//
//  Created by Ondrej Rafaj on 11/10/2018.
//

import Foundation
import UIKit


open class MyCollectionView: UICollectionView {
    
    open override func reloadData() {
        super.reloadData()
        super.collectionViewLayout.invalidateLayout()
    }
    
}
