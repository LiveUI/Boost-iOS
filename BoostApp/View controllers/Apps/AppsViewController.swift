//
//  AppsViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 30/11/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import SnapKit


class AppsViewController: ViewController {
    
    let dataController = AppsDataManager()
    let collectionView: UICollectionView
    
    
    // MARK: Initialization
    
    init() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    func layoutElements() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Elements
    
    func configureCollectionView() {
        collectionView.register(AppCollectionViewCell.self)
        
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    func configureElements() {
        configureCollectionView()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureElements()
        layoutElements()
        
        // Do the binding
        var dc: CollectionViewPresentableManager = dataController
        collectionView.bind(withPresentableManager: &dc)
        
        dataController.loadData()
    }
    
}
