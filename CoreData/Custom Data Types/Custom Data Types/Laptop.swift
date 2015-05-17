//
//  Laptop.swift
//  Custom Data Types
//
//  Created by Domenico Solazzo on 17/05/15.
//  License MIT
//

import Foundation
import CoreData

@objc(Laptop) class Laptop: NSManagedObject {

    @NSManaged var model: String
    @NSManaged var color: AnyObject

}
