//
//  LeftMenuViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import SideMenu
import Presentables
import AwesomeEnum
import Modular


class LeftMenuViewController: ViewController, UIScrollViewDelegate {
    
    let accounts = AccountsViewController()
    let teams = TeamsViewController()
    
    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    
    let fakeNavBar = MenuTopBarView()
    
    enum Page {
        case accounts
        case teams
    }
    
    // MARK: Settings
    
    func show(page: Page, animated: Bool = true) {
        switch page {
        case .accounts:
            scrollView.setContentOffset(CGPoint(x: 0, y: -20), animated: true)
            navigationItem.setLeftBarButton(nil, animated: animated)
        case .teams:
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width, y: -20), animated: animated)
            makeAccountIcon()
        }
    }
    
    func reloadData() {
        accounts.manager.reloadAccounts()
    }
    
    func didLogin(to account: Account) {
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
        
        scrollView.isScrollEnabled = true
        show(page: .teams)
        
        teams.manager.account = account
        teams.accountButton.setImage(account.iconImage, for: .normal)
    }
    
    func didLogOut() {
        pageControl.numberOfPages = 1
        pageControl.currentPage = 0
        
        scrollView.isScrollEnabled = false
        show(page: .accounts)
    }
    
    // MARK: Elements
    
    func makeAccountIcon() {
        let button = UIButton()
        button.setImage(teams.manager.account?.iconImage, for: .normal)
        button.layer.cornerRadius = 3
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapAccountIcon(_:)), for: .touchUpInside)
        let icon = UIBarButtonItem(customView: button)
        navigationItem.setLeftBarButton(icon, animated: true)
    }
    
    override func configureElements() {
        super.configureElements()
        
        navigationController?.navigationBar.isTranslucent = false
        
        // Fake nav bar & bcg
        fakeNavBar.place.on(view, top: 20).sideToSide().with.height(54)
        view.backgroundColor = Theme.default.menuBackgroundColor.hexColor
        
        scrollView.isScrollEnabled = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.equalTo(0)
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.height)
        }
        
        // Accounts
        addChildViewController(accounts)
        accounts.view.place.on(scrollView, top: 0, bottom: 0).leftMargin(0).match(width: scrollView).match(height: scrollView, offset: -20)
        accounts.didMove(toParentViewController: self)
        
        // Teams
        addChildViewController(teams)
        teams.view.place.next(to: accounts.view, left: 0).rightMargin(0)
        teams.view.snp.makeConstraints { make in
            make.width.height.top.equalTo(accounts.view)
        }
        teams.didMove(toParentViewController: self)
        
        // Pagination
        pageControl.numberOfPages = 1
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .lightGray
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        pageControl.place.on(view, height: 20, bottom: -20).sideMargins()
    }
    
    // MARK: View lifecycle
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Can we find a cleaner way to identify which page should be open?
        if pageControl.numberOfPages > 1 {
            show(page: .teams, animated: true)
        }
    }
    
    // MARK: Actions
    
    @objc func didTapAccountIcon(_ sender: UIButton) {
        show(page: .accounts)
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        show(page: (sender.currentPage == 0 ? .accounts : .teams))
    }
    
    // MARK: Scrollview delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        var page = round(((scrollView.contentOffset.x + width) / width) - 1)
        if page.isNaN {
            page = 0
        }
        if page > 0 {
            if navigationItem.leftBarButtonItem == nil {
                makeAccountIcon()
            }
        } else {
            if navigationItem.leftBarButtonItem != nil {
                navigationItem.setLeftBarButton(nil, animated: true)
            }
        }
        pageControl.currentPage = Int(page)
        
        // TODO: Fix the layout issue so we can get rid of this hack!!!!
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: -20)
    }
    
}

// MARK: - Left menu Base view controller

class LeftBaseViewController: UISideMenuNavigationController {
    
    
    // MARK: View lifecycle
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
