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
let kHeroValidationBirthdateCode = 1000
let kHeroValidationNameOrSecretIdentityCode = 1001

@objc(Hero) class Hero: NSManagedObject {

    @NSManaged var birthDate: NSDate
    @NSManaged var favoriteColor: UIColor
    @NSManaged var name: String
    @NSManaged var secretIdentity: String
    @NSManaged var sex: String
    var age:Int{
        get{
            var gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            var today = NSDate()
            var components = gregorian?.components(NSCalendarUnit.YearCalendarUnit, fromDate: self.birthDate, toDate: NSDate(), options: NSCalendarOptions.allZeros)
            var year = components?.year
            return year!
        }
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.favoriteColor = UIColor(red:1, green:1, blue:1, alpha:1)
        self.birthDate = NSDate()
    }
    
    func validateBirthDate(ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>,
        error:NSErrorPointer) -> Bool {
            var date = ioValue.memory as! NSDate
            if date.compare(NSDate()) == .OrderedDescending {
                if error != nil {
                    var errorStr = NSLocalizedString("Birthdate cannot be in the future",
                        comment: "Birthdate cannot be in the future")
                    var userInfo = NSDictionary(object: errorStr, forKey: NSLocalizedDescriptionKey)
                    var outError = NSError(domain: kHeroValidationDomain,
                        code: kHeroValidationBirthdateCode,
                        userInfo: userInfo as [NSObject : AnyObject])
                    error.memory = outError
                }
                return false
            }
            return true
    }

}
