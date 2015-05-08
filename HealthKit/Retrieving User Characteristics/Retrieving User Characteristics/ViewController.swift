//
//  ViewController.swift
//  Retrieving User Characteristics
//
//  Created by Domenico Solazzo on 08/05/15.
//  License MIT
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    // Date of birth characteristic type
    let dateOfBirthType = HKCharacteristicType.quantityTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)
    
    // Types that you want to read
    lazy var types: Set<NSObject> = {
        return Set<NSObject>(arrayLiteral: self.dateOfBirthType)
    }()
    
    // HealthKit store
    lazy var healthStore = HKHealthStore()

    /* Ask for permission to access the health store */
    override func viewDidAppear(animated: Bool) {
        if HKHealthStore.isHealthDataAvailable(){
            healthStore.requestAuthorizationToShareTypes(nil, readTypes: types, completion: {[weak self]
                (succeeded:Bool, error:NSError!) -> Void in
                let strongSelf = self!
                if succeeded && error == nil{
                    dispatch_async(dispatch_get_main_queue(), strongSelf.readDateOfBirthInformation)
                }else{
                    if let theError = error{
                        println("Error occurred \(theError)")
                    }
                }
            })
        }else{
            println("Health data is not available")
        }
    }
    
    func readDateOfBirthInformation(){
        var dateOfBirthError: NSError?
        let birthDate = healthStore.dateOfBirthWithError(&dateOfBirthError) as NSDate?
        
        if let error = dateOfBirthError{
            println("Could not read user's date of birth")
        }else{
            if let dateOfBirth = birthDate{
                let formatter = NSNumberFormatter()
                let now = NSDate()
                let components = NSCalendar.currentCalendar().components(
                    NSCalendarUnit.YearCalendarUnit,
                    fromDate: birthDate!,
                    toDate: now,
                    options: NSCalendarOptions.WrapComponents)
                
                let age = components.year
                
                println("The user is \(age) years old")
            }else{
                println("User has not specified the date of birth")
            }
        }
    }
}

