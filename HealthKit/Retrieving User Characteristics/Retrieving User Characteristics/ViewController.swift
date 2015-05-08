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

    // User characteristic: you cannot write user characteristics
    let dateOfBirthCharacteristicType =
    HKCharacteristicType.characteristicTypeForIdentifier(
        HKCharacteristicTypeIdentifierDateOfBirth)
    
    lazy var types: NSSet = {
        return NSSet(object: self.dateOfBirthCharacteristicType)
        }()
    
    // The health store
    lazy var healthStore = HKHealthStore()

    /* Ask for permission to access the health store */
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if HKHealthStore.isHealthDataAvailable(){
            
            healthStore.requestAuthorizationToShareTypes(nil,
                readTypes: types as Set<NSObject>,
                completion: {[weak self]
                    (succeeded: Bool, error: NSError!) in
                    
                    let strongSelf = self!
                    if succeeded && error == nil{
                        dispatch_async(dispatch_get_main_queue(),
                            strongSelf.readDateOfBirthInformation)
                    } else {
                        if let theError = error{
                            println("Error occurred = \(theError)")
                        }
                    }
                    
                })
            
        } else {
            println("Health data is not available")
        }
    }
    
    func readDateOfBirthInformation(){
        
        var dateOfBirthError: NSError?
        let birthDate = healthStore.dateOfBirthWithError(&dateOfBirthError)
            as NSDate?
        
        if let error = dateOfBirthError{
            println("Could not read user's date of birth")
        } else {
            
            if let dateOfBirth = birthDate{
                let formatter = NSNumberFormatter()
                let now = NSDate()
                let components = NSCalendar.currentCalendar().components(
                    .YearCalendarUnit,
                    fromDate: dateOfBirth,
                    toDate: now,
                    options: .WrapComponents)
                
                let age = components.year
                
                println("The user is \(age) years old")
            } else {
                println("User has not specified her date of birth yet")
            }
            
        }
        
    }
}

