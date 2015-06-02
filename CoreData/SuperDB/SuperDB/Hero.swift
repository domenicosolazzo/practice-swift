//
//  Hero.swift
//  SuperDB
//
//  Created by Domenico on 02/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreData

let kHeroValidationDomain = "com.oz-apps.SuperDB.HeroValidationDomain"
let kHeroValidationBirthdateCode = 1000
let kHeroValidationNameOrSecretIdentityCode = 1001

@objc(Hero)
class Hero: NSManagedObject {
    
    @NSManaged var birthDate: NSDate
    @NSManaged var name: String
    @NSManaged var secretIdentity: String
    @NSManaged var sex: String
    @NSManaged var favoriteColor: UIColor
    
    var age:Int {
        get {
            if self.birthDate != NSNull() {
                var gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                var today = NSDate()
                var components = gregorian?.components(NSCalendarUnit.CalendarUnitYear, fromDate: self.birthDate, toDate: NSDate(), options: .allZeros)
                var years = components?.year
                return years!
            }
            return 0
        }
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.favoriteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.birthDate = NSDate()
    }
    
    //    override func validateValue(value: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey key: String, error: NSErrorPointer) -> Bool {
    //        println("Key: \(key)")
    //
    //        if key == "secretIdentity" {
    //            println(">> We validate this to true and reject the rest")
    //        } else {
    //            var theErr:NSError? = NSError(domain: kHeroValidationDomain, code: 1007, userInfo: nil)
    //            error.memory = theErr
    //            return false
    //        }
    //        return true
    //    }
    
    
    func validateBirthDate(ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>, error:NSErrorPointer) -> Bool {
        var date = ioValue.memory as! NSDate
        if date.compare(NSDate()) == .OrderedDescending {
            if error != nil {
                var errorStr = NSLocalizedString("Birthdate cannot be in the future",
                    comment: "Birthdate cannot be in the future")
                var userInfo = NSDictionary(object: errorStr, forKey: NSLocalizedDescriptionKey)
                var outError = NSError(domain: kHeroValidationDomain, code: kHeroValidationBirthdateCode, userInfo: userInfo as [NSObject : AnyObject])
                error.memory = outError
            }
            return false
        }
        return true
    }
    
    
    //    override func willAccessValueForKey(key: String?) {
    //        println(">> accessing \(key)")
    //        if key == "age" {
    //            //age = theAge
    //        }
    //    }
    
    
    
    
    func validateNameOrSecretIdentity(error :NSErrorPointer) -> Bool{
        if count(self.name) < 2 && count(self.secretIdentity) == 0 {
            if error != nil {
                var errorStr = NSLocalizedString("Must provide name or secret identity.",
                    comment: "Must provide name or secret identity.")
                var userInfo = NSDictionary(object: errorStr, forKey: NSLocalizedDescriptionKey)
                var outError = NSError(domain: kHeroValidationDomain, code: kHeroValidationNameOrSecretIdentityCode, userInfo: userInfo as [NSObject : AnyObject])
                error.memory =  outError
            }
            return false
        }
        
        return true
    }
    
    override func validateForInsert(error: NSErrorPointer) -> Bool {
        return self.validateNameOrSecretIdentity(error)
    }
    
    override func validateForUpdate(error: NSErrorPointer) -> Bool {
        return self.validateNameOrSecretIdentity(error)
    }
    
    
}
