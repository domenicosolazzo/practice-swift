//
//  ViewController.swift
//  Observing changes in HealthKit
//
//  Created by Domenico Solazzo on 08/05/15.
//  License MIT
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    // Body mass
    let weightQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
    
    lazy var types: Set<NSObject> = {
        return Set<NSObject>(arrayLiteral: self.weightQuantityType)
    }()
    
    // Health store
    lazy var healthStore = HKHealthStore()
}

