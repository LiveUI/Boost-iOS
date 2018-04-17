//
//  RootViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 17/12/2017.
//  Copyright © 2017 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import BoostSDK
import AwesomeEnum
import Presentables
import Modular
import SnapKit
import MaterialComponents


class RootViewController: ViewController {
    
    var manager: PresentableCollectionViewDataManager & AppManager
    
    lazy var selectedTagsManager: SelectedTagsDataManager = {
        return SelectedTagsDataManager()
    }()
    
//    lazy var tagListView: UICollectionView = {
//        let layout = MDCChipCollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 150, height: 44)
//        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        return collectionView
//    }()
    
    var layout = StoreFrontCollectionViewLayout()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var screenBlocker = UIView()
    var filtersMenu = FiltersViewController()
    
    var tags: [String] = [] {
        didSet {
            selectedTagsManager.tags = tags
            
//            manager.selectedTags = tags
            filtersMenu.dataController.selectedTags = tags
            
//            tagListView.reloadData()
        }
    }
    
    
    // MARK: Initialization
    
    init(manager: PresentableCollectionViewDataManager & AppManager) {
        self.manager = manager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    var filtersMenuLeftConstraint: Constraint!
    
    func layoutElements() {
        filtersMenu.view.snp.makeConstraints { (make) in
            filtersMenuLeftConstraint = make.left.equalTo(self.view.snp.right).offset(0).constraint
            make.width.equalTo(300)
            make.height.equalToSuperview()
        }
    }
    
    // MARK: Elements
    
    func configureNavBar() {
        let settings = Awesome.solid.ellipsisV.navBarIcon()
        let settingsButton = UIBarButtonItem(image: settings, style: .plain, target: self, action: #selector(RootViewController.didTapFilters(_:)))
        navigationItem.setLeftBarButtonItems([navigationItem.leftBarButtonItem!, settingsButton], animated: false)
        
        let filter = Awesome.solid.filter.navBarIcon()
        let filterButton = UIBarButtonItem(image: filter, style: .plain, target: self, action: #selector(RootViewController.didTapFilters(_:)))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    func configureCollectionView() {
        collectionView.register(header: AppHeader.self)
        collectionView.register(header: FakeAppHeader.self)
        collectionView.register(AppCollectionViewCell.self)
        collectionView.register(FakeAppCollectionViewCell.self)
        collectionView.backgroundColor = .white
        collectionView.place.on(view, top: 0).sideToSide().and.bottomMargin(0)
    }
    
    func configureBlocker() {
        screenBlocker.alpha = 0
        screenBlocker.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        screenBlocker.place.on(andFill: view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RootViewController.didTapFilters(_:)))
        screenBlocker.addGestureRecognizer(tap)
    }
    
    func configureFilters() {
        filtersMenu.tagsChanged = { tags in
            self.tags = tags
//            self.updateTagListViewHeight(animated: true)
        }
        addChildViewController(filtersMenu)
        view.addSubview(filtersMenu.view)
        filtersMenu.didMove(toParentViewController: self)
    }
    
    override func configureElements() {
        super.configureElements()
        
        navigationController?.navigationBar.isTranslucent = false
        
        configureNavBar()
        configureCollectionView()
        configureBlocker()
        configureFilters()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutElements()
        
        // Do the binding
        var dc: PresentableManager = manager
        collectionView.bind(withPresentableManager: &dc)
        
        manager.appActionRequested = { app in
            self.actionTriggered(for: app)
        }
        manager.appDetailRequested = { app in
            let c = AppDetailViewController()
            c.appActionRequested = { app in
                self.actionTriggered(for: app)
            }
            c.app = app
            let nc = UINavigationController(rootViewController: c)
            if UIDevice.current.userInterfaceIdiom == .pad {
                nc.modalPresentationStyle = .formSheet
            }
            self.present(nc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        updateTagListViewHeight()
        
        self.layout.screenSize = view.bounds.size
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { ctx in
            self.layout.screenSize = size
        })
    }
    
    // MARK: Animations
    
//    func updateTagListViewHeight(animated: Bool = false) {
//        view.layoutIfNeeded()
//
//        let height = tagListView.intrinsicContentSize.height
//        tagListView.snp.updateConstraints { (make) in
//            make.top.equalTo((height > 0 ? 12 : 0))
//            make.height.equalTo(height)
//        }
//        collectionView.snp.updateConstraints { (make) in
//            make.top.equalTo(tagListView.snp.bottom).offset((height > 0 ? 12 : 0))
//        }
//
//        if animated {
//            UIView.animate(withDuration: 0.3, animations: {
//                self.view.layoutIfNeeded()
//            })
//        }
//        else {
//            view.layoutIfNeeded()
//        }
//    }
    
    func toggleFilters() {
        let hidden: Bool = (filtersMenu.view.frame.origin.x == view.frame.size.width)
        filtersMenuLeftConstraint.update(offset: hidden ? -300 : 0)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
            self.screenBlocker.alpha = hidden ? 1 : 0
        })
    }
    
    // MARK: Actions
    
    func actionTriggered(for app: App) {
        print("Downloading: \(app.name)")
    }
    
    @objc func didTapFilters(_ sender: AnyObject) {
        toggleFilters()
    }
    
}
