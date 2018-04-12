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
    
    enum Page {
        case accounts
        case teams
    }
    
    // MARK: Settings
    
    func show(page: Page) {
        switch page {
        case .accounts:
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            navigationItem.setLeftBarButton(nil, animated: true)
        case .teams:
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width, y: 0), animated: true)
            makeAccountIcon()
        }
    }
    
    func reloadData() {
        accounts.manager.reloadAccounts()
        accounts.setupEditButton()
    }
    
    func didLogin(to account: Account) {
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
        
        scrollView.isScrollEnabled = true
        show(page: .teams)
        
        teams.manager.account = account
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
        
        scrollView.isScrollEnabled = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.place.on(andFill: view)
        
        // Accounts
        addChildViewController(accounts)
        accounts.view.place.on(scrollView, top: 0, bottom: 0).leftMargin(0).match(width: scrollView).match(height: scrollView)
        accounts.didMove(toParentViewController: self)
        
        // Teams
        addChildViewController(teams)
        teams.view.place.next(to: accounts.view).match(bottom: scrollView).match(width: scrollView).rightMargin(0)
        teams.didMove(toParentViewController: self)
        
        // Pagination
        pageControl.numberOfPages = 1
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        pageControl.place.on(view, height: 20, bottom: -20).sideMargins()
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
        let page = round(((scrollView.contentOffset.x + width) / width) - 1)
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
    }
    
}

// MARK: - Left menu Base view controller

class LeftBaseViewController: UISideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
