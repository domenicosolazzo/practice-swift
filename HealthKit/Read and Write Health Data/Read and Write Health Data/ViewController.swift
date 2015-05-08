//
//  ViewController.swift
//  Read and Write Health Data
//
//  Created by Domenico Solazzo on 08/05/15.
//  License MIT
//

import UIKit
import HealthKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    /*
        This is the label that shows the user's weight unit (Kilograms)
        the righthand side of our text field
    */
    let textFieldRightLabel = UILabel(frame: CGRectZero)
    
    // Height
    let heightQuantity = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)
    // Weight
    let weightQuantity = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
    // Hearth rate
    let hearthRateQuantity = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
    
    // Health kit store
    lazy var healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
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
            healthStore.requestAuthorizationToShareTypes(typesToShare, readTypes: typesToRead){ (succeeded: Bool, error: NSError!) in
                if succeeded && error == nil{
                    println("Authorization succeeded")
                }else{
                    if let theError = error{
                        println("Error \(theError)")
                    }
                }
            }
        }else{
            println("HealthData is not available")
        }
    }
}

