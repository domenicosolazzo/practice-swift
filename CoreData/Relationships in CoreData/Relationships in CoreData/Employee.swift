//
//  Employee.swift
//  Relationships in CoreData
//
//  Created by Domenico Solazzo on 17/05/15.
//  License MIT
//

import Foundation
import CoreData

class Employee: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var age: NSNumber
    @NSManaged var manager: NSSet

}
