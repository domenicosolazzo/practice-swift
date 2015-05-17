//
//  Person.swift
//  Deleting data from CoreData
//
//  Created by Domenico Solazzo on 17/05/15.
//  License MIT
//

import Foundation
import CoreData

@objc(Person) class Person: NSManagedObject {
    
    @NSManaged var age: NSNumber
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    
}

