//
//  AppHeader.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import Presentables
import Modular


class AppHeader: UICollectionReusableView, Presentable {
    
    var didPressDeleteAll: (()->())?
    var didPressShowAll: (()->())?
    
    private let deleteAll = UIButton()
    let titleLabel = UILabel()
    private let showAll = UIButton()
    
    
    // MARK: Configure elements
    
    func configureElements() {
        backgroundColor = .lightGray
        
        deleteAll.setTitle("Delete", for: .normal)
        deleteAll.addTarget(self, action: #selector(didPressDeleteAll(_:)), for: .touchUpInside)
        deleteAll.place.on(self).with.leftMargin().topMargin(0).bottomMargin(4).and.height(24)
        
        showAll.setTitle("All ->", for: .normal)
        showAll.addTarget(self, action: #selector(didPressShowAll(_:)), for: .touchUpInside)
        showAll.place.on(self).with.rightMargin().topMargin(0).bottomMargin(4).and.height(24)
        
        titleLabel.place.between(deleteAll, and: showAll, height: 24).topMargin(8)
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func didPressDeleteAll(_ sender: UIButton) {
        didPressDeleteAll?()
    }
    
    @objc func didPressShowAll(_ sender: UIButton) {
        didPressShowAll?()
    }
    
}


class AppHeaderPresenter: PresenterHeader {
    
    var presentable: Presentable.Type = AppHeader.self
    
    var configure: ((Presentable) -> ())?
    
}
