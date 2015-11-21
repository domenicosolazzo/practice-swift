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

class Hero: NSManagedObject {
    
    @NSManaged var birthDate: NSDate
    @NSManaged var name: String
    @NSManaged var secretIdentity: String
    @NSManaged var sex: String
    @NSManaged var favoriteColor: UIColor
    
    var age:NSNumber {
        get {
            if self.birthDate != NSNull() {
                let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                var today = NSDate()
                let components = gregorian?.components(NSCalendarUnit.Year, fromDate: self.birthDate, toDate: NSDate(), options: [])
                let years = components?.year
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
    
    
    
    func validateBirthDate(ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>) throws {
        var date = ioValue.memory as! NSDate
        if date.compare(NSDate()) == .OrderedDescending {
            var errorStr = NSLocalizedString("Birthdate cannot be in the future",
                comment: "Birthdate cannot be in the future")
            var userInfo = NSDictionary(object: errorStr, forKey: NSLocalizedDescriptionKey)
            var outError = NSError(domain: kHeroValidationDomain, code: kHeroValidationBirthdateCode, userInfo: userInfo as! [NSObject : AnyObject])
            throw outError
        }
    }
    
    func validateNameOrSecretIdentity() throws{
        if self.name.characters.count < 2 && self.secretIdentity.characters.count == 0 {
            var errorStr = NSLocalizedString("Must provide name or secret identity.",
                comment: "Must provide name or secret identity.")
            var userInfo = NSDictionary(object: errorStr, forKey: NSLocalizedDescriptionKey)
            var outError = NSError(domain: kHeroValidationDomain, code: kHeroValidationNameOrSecretIdentityCode, userInfo: userInfo as! [NSObject : AnyObject])
            throw outError
        }
    }
    
    override func validateForInsert() throws {
        try self.validateNameOrSecretIdentity()
    }
    
    override func validateForUpdate() throws {
        try self.validateNameOrSecretIdentity()
    }
    
    
}
