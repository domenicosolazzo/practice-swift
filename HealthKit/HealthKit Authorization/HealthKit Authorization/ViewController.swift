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
    let heightQuantity = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
    // Weight
    let weightQuantity = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
    // Hearth rate
    let hearthRateQuantity = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)
    
    // Health kit store
    lazy var healthStore = HKHealthStore()
    
    // Information that we would write into the HealthKit
    lazy var typesToShare: Set<HKSampleType> = {
        return Set<HKSampleType>()
    }()
    
    // We want to read these types of data */
    lazy var typesToRead: Set<HKSampleType> = {
        return Set<HKSampleType>()
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
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

