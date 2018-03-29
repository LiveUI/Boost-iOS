//
//  CenterViewController.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 21/03/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CenterViewController: ViewController {
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
    var q: Query? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDelegate.coordinator.refresh(menuWidth: view.frame.size.width)
        
        do {
            let account = try CoreData.new(Account.self)
            account.name = ":)"
            try account.save()
            
            
            q = Account.query.sort(by: \Account.name)
            
            
            
        } catch {
            print(error)
        }
        
        
        
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
        
        let fetch = Account.fetchRequest
        do {
            let data = try CoreData.managedContext.fetch(fetch) as! [Account]
            print(data.count)
        } catch {
            print(error)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        appDelegate.coordinator.refresh(menuWidth: size.width)
    }
    
}
