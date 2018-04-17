//
//  AppCollectionViewCell.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 01/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AwesomeEnum


class AppCollectionViewCell: UICollectionViewCell {
    
    let iconView = UIImageView()
    let nameLabel = MainContentLabel()
    let uploadedLabel = SmallTextLabel()
    let infoLabel = SmallTextLabel()
    
    let installButton = UIButton()
    
    var didTapActionButton: ((_ sender: UIButton)->())?
    
    
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
            
            let width = installButton.imageView?.image?.size.width ?? 44
            make.width.equalTo(width)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(Env.cellSpacing)
            make.top.equalTo(iconView)
            make.right.equalTo(installButton.snp.left).offset(-Env.cellSpacing)
        }
    }
    
    // MARK: Configuration
    
    private func configureIconView() {
        iconView.backgroundColor = .red
        iconView.layer.cornerRadius = 10
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
    }
    
    private func configureLabels() {
        nameLabel.numberOfLines = 2
        contentView.addSubview(nameLabel)
    }
    
    private func configureButtons() {
        installButton.setImage(Awesome.solid.download.asImage(size: 34, color: installButton.tintColor), for: .normal)
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
    
    func configureElements() {
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
        didTapActionButton?(sender)
    }
    
}
