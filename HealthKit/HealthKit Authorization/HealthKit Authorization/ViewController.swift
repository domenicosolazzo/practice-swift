//
//  ViewController.swift
//  HealthKit Authorization
//
//  Created by Domenico Solazzo on 08/05/15.
//  License MIT
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    // Height
    let heightQuantity = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
    // Weight
    let weightQuantity = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
    // Hearth rate
    let hearthRateQuantity = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
    
    // Health kit store
    lazy var healthStore = HKHealthStore()
    
    // Information that we would write into the HealthKit
    lazy var typesToShare: Set<NSObject> = {
        return Set<NSObject>(arrayLiteral: self.heightQuantity, self.weightQuantity)
    }()
    
    // We want to read these types of data */
    lazy var typesToRead: Set<NSObject> = {
        return Set<NSObject>(arrayLiteral: self.heightQuantity,
            self.weightQuantity,
            self.hearthRateQuantity
        )
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if the HealthKit is available
        if HKHealthStore.isHealthDataAvailable(){
            // Request authorization
            healthStore.requestAuthorizationToShareTypes(typesToShare, readTypes: typesToRead){ (succeeded: Bool, error: NSError?) in
                if succeeded && error == nil{
                    print("Authorization succeeded")
                }else{
                    if let theError = error{
                        print("Error \(theError)")
                    }
                }
            }
        }else{
            print("HealthData is not available")
        }
    }
}

