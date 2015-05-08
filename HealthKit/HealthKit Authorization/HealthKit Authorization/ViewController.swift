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
    
    // Information that we wouldn't write into the HealthKit
    lazy var typesToShare: NSSet = {
        return NSSet(objects: self.heightQuantity, self.weightQuantity)
    }()
    
    // We want to read these types of data */
    lazy var typesToRead: NSSet = {
        return NSSet(objects: self.heightQuantity,
            self.weightQuantity,
            self.hearthRateQuantity
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

