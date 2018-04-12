//
//  FakeAppCollectionViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 09/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AwesomeEnum


class FakeAppCollectionViewCell: UICollectionViewCell {
    
    let iconView = UIImageView()
    let nameLabel = UILabel()
    let uploadedLabel = UILabel()
    let infoLabel = UILabel()
    
    let installButton = UIButton()
    
    
    // MARK: Layout
    
    private func layoutElements() {
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(Env.cellSpacing)
            make.top.equalTo(Env.cellSpacing)
            make.bottom.equalTo(-Env.cellSpacing)
            make.width.equalTo(iconView.snp.height)
        }
        
        installButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-Env.cellSpacing)
            make.height.equalTo(Env.actionButtonHeight)
            make.width.equalTo(installButton.imageView!.image!.size.width)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(Env.cellSpacing)
            make.top.equalTo(iconView)
            make.right.equalTo(installButton.snp.left).offset(-Env.cellSpacing)
        }
    }
    
    // MARK: Configuration
    
    private func configureIconView() {
        iconView.backgroundColor = .lightGray
        iconView.layer.cornerRadius = 10
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
    }
    
    private func configureLabels() {
        nameLabel.textColor = .lightGray
        nameLabel.backgroundColor = .lightGray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.numberOfLines = 2
        contentView.addSubview(nameLabel)
    }
    
    private func configureButtons() {
        installButton.setTitleColor(.lightGray, for: .normal)
        installButton.backgroundColor = .lightGray
        installButton.addTarget(self, action: #selector(didTapInstallButton(_:)), for: .touchUpInside)
        contentView.addSubview(installButton)
    }
    
    private func configureStaticElements() {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        contentView.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func configureElements() {
        configureIconView()
        configureLabels()
        configureButtons()
        configureStaticElements()
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        configureElements()
        layoutElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func didTapInstallButton(_ sender: UIButton) {
        
    }
    
}
