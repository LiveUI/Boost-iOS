//
//  CenterViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import Reloaded


class CenterViewController: ViewController {
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
    var q: Query<Account>! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDelegate.coordinator.refresh(menuWidth: view.frame.size.width)
        
//        do {
//            var account = try CoreData.new(Account.self)
//            account.name = "aaaaaa"
//            account = try CoreData.new(Account.self)
//            account.name = "cccccc"
//            account.server = "zzzzz"
//            account = try CoreData.new(Account.self)
//            account.name = "cccccc"
//            account.server = "aaaaaa"
//            account = try CoreData.new(Account.self)
//            account.name = "cccccc"
//            account.server = "ggggg"
//            account = try CoreData.new(Account.self)
//            account.name = "hhhhh"
//            account = try CoreData.new(Account.self)
//            account.name = "zzzzz"
//            account = try CoreData.new(Account.self)
//            account.name = "dddddd"
//            try account.save()
//
//
//            let data = try! Account.query.filter("name" == "cccccc", "name" == "zzzzz").sort(by: "server", direction: .orderedAscending).all()
//            print(data)
//
//
//        } catch {
//            print(error)
//        }
        
        
        
//        do {
//            let accounts = try Account.all()
//            print(accounts)
//        } catch {
//            print(error)
//        }
//
//        do {
//            let accounts = try Account.all(filter: NSPredicate(value: true), sort: [NSSortDescriptor(key: "name", ascending: true)], limit: 20)
//            print(accounts)
//        } catch {
//            print(error)
//        }
//
//        do {
//            let count = try Account.count()
//            print(count)
//        } catch {
//            print(error)
//        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        appDelegate.coordinator.refresh(menuWidth: size.width)
    }
    
}
