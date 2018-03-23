//
//  AppDetailViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 01/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Presentables
import SnapKit
import Awesome
import BoostSDK


class AppDetailViewController: ViewController {
    
    var app: App! {
        didSet {
            nameLabel.text = app.name
        }
    }
    
    let iconView = UIImageView()
    let nameLabel = UILabel()
    let uploadedLabel = UILabel()
    let infoLabel = UILabel()
    
    let installButton = UIButton()
    
    var appActionRequested: ((App)->())?
    
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        edgesForExtendedLayout = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    func layoutElements() {
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(Env.spacing)
            make.top.equalTo(Env.spacing)
            make.height.equalTo(120)
            make.width.equalTo(iconView.snp.height)
        }
        
        installButton.snp.makeConstraints { (make) in
            make.top.equalTo(iconView)
            make.right.equalTo(-Env.spacing)
            make.height.equalTo(Env.actionButtonHeight)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(Env.spacing)
            make.top.equalTo(iconView)
            make.right.equalTo(installButton.snp.left).offset(-Env.spacing)
        }
    }
    
    // MARK: Elements
    
    func configureNavBar() {
        let close = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose(_:)))
        navigationItem.leftBarButtonItem = close
    }
    
    private func configureIconView() {
        iconView.backgroundColor = .red
        iconView.layer.cornerRadius = 10
        iconView.clipsToBounds = true
        view.addSubview(iconView)
    }
    
    private func configureLabels() {
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.numberOfLines = 2
        view.addSubview(nameLabel)
    }
    
    private func configureButtons() {
        installButton.setImage(Awesome.light.cloudDownload.asImage(size: 34, color: installButton.tintColor), for: .normal)
        installButton.addTarget(self, action: #selector(didTapActionButton(_:)), for: .touchUpInside)
        view.addSubview(installButton)
    }
    
    private func configureStaticElements() {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        view.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func configureElements() {
        view.backgroundColor = .white
        
        configureNavBar()
        configureIconView()
        configureLabels()
        configureButtons()
        configureStaticElements()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutElements()
    }
    
    // MARK: Actions
    
    @objc func didTapClose(_ sender: UIBarButtonItem) {
        guard let navigationController = navigationController, navigationController.viewControllers.count > 1 else {
            dismiss(animated: true, completion: nil)
            return
        }
        navigationController.popViewController(animated: true)
    }
    
    @objc func didTapActionButton(_ sender: UIButton) {
        appActionRequested?(app)
    }
    
}
