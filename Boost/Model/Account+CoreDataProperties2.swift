//
//  Account+CoreDataProperties.swift
//  
//
//  Created by Ondrej Rafaj on 28/03/2018.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var name: String?
    @NSManaged public var server: String?
    @NSManaged public var token: String?

}
