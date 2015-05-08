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
    
    // Predicate
    lazy var predicate: NSPredicate = {
        let now = NSDate()
        
        let yesterday = NSCalendar.currentCalendar().dateByAddingUnit(
            unit: NSCalendarUnit.DayCalendarUnit,
            value: -1,
            toDate: now,
            options: NSCalendarOptions.WrapComponents)
        
        return HKQuery.predicateForSamplesWithStartDate(
            yesterday,
            endDate: now,
            options: HKQueryOptions.StrictEndDate)
    }
    
    // Observer Query
    lazy var query: HKObserverQuery = {[weak self] in
        let strongSelf = self!
        return HKObserverQuery(sampleType: strongSelf.weightQuantityType,
            predicate: strongSelf.predicate,
            updateHandler: strongSelf.weightChangedHandler
        )
    }
}

