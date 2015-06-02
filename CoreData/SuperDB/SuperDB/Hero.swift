//
//  Hero.swift
//  
//
//  Created by Domenico on 02/06/15.
//
//

import Foundation
import CoreData
import UIKit

let kHeroValidationDomain = "com.domenicosolazzo.superDB.HeroValidationDomain"
let kHeroValidationBirthday = 1000
let kHeroValidationNameOrSecretIdentityCode = 1001

class Hero: NSManagedObject {

    var age:Int
    @NSManaged var birthDate: NSDate
    @NSManaged var favoriteColor: UIColor
    @NSManaged var name: String
    @NSManaged var secretIdentity: String
    @NSManaged var sex: String
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.favoriteColor = UIColor(red:1, green:1, blue:1, alpha:1)
    }

}
