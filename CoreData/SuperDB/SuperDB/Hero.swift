//
//  Hero.swift
//  
//
//  Created by Domenico on 02/06/15.
//
//

import Foundation
import CoreData

class Hero: NSManagedObject {

    @NSManaged var age: NSNumber
    @NSManaged var birthDate: NSDate
    @NSManaged var favoriteColor: AnyObject
    @NSManaged var name: String
    @NSManaged var secretIdentity: String
    @NSManaged var sex: String

}
