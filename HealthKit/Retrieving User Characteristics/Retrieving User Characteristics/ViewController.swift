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

}

