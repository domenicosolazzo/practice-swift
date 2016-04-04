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
    
    // Weight
    let weightQuantityType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
    
    // Health kit store
    lazy var healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.rightView = textFieldRightLabel
        textField.rightViewMode = .Always
    }
    
    
    // Information that we would write into the HealthKit
    lazy var typesToShare: Set<NSObject> = {
        return Set<NSObject>(arrayLiteral: self.weightQuantityType)
        }()
    
    // We want to read these types of data */
    lazy var typesToRead: Set<NSObject> = {
        return Set<NSObject>(arrayLiteral:
            self.weightQuantityType
        )
        }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if the HealthKit is available
        if HKHealthStore.isHealthDataAvailable(){
            // Request authorization
            healthStore.requestAuthorizationToShareTypes(typesToShare,
                readTypes: typesToRead){[weak self](succeeded: Bool, error: NSError!) in
                
                let strongSelf = self!
                if succeeded && error == nil{
                    strongSelf.readWeightInformation()
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
    
    func readWeightInformation(){
        // Sorting. Descending.
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // Set the query
        let query = HKSampleQuery(sampleType: weightQuantityType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sortDescriptor],
            resultsHandler: {[weak self] (query: HKSampleQuery!,
                results: [AnyObject]!,
                error: NSError!) in
                
                if results.count > 0{
                    
                    /* We really have only one sample */
                    let sample = results[0] as! HKQuantitySample
                    /* Get the weight in kilograms from the quantity */
                    let weightInKilograms = sample.quantity.doubleValueForUnit(
                        HKUnit.gramUnitWithMetricPrefix(.Kilo))
                    
                    /* This is the value of KG, localized in user's language */
                    let formatter = NSMassFormatter()
                    let kilogramSuffix = formatter.unitStringFromValue(weightInKilograms,
                        unit: .Kilogram)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        let strongSelf = self!
                        
                        
                        /* Set the value of KG on the righthand side of the
                        text field */
                        strongSelf.textFieldRightLabel.text = kilogramSuffix
                        strongSelf.textFieldRightLabel.sizeToFit()
                        
                        /* And finally set the text field's value to the user's
                        weight */
                        let weightFormattedAsString =
                        NSNumberFormatter.localizedStringFromNumber(
                            NSNumber(double: weightInKilograms),
                            numberStyle: .NoStyle)
                        
                        strongSelf.textField.text = weightFormattedAsString
                        
                    })
                    
                } else {
                    print("Could not read the user's weight ", terminator: "")
                    print("or no weight data was available")
                }
                
                
            })
        // Execute the query
        healthStore.executeQuery(query)
    }
    
    // Saving
    @IBAction func saveUserWeight(){
        let kilogramUnit = HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Kilo)
        let weightQuantity = HKQuantity(unit: kilogramUnit,
            doubleValue: (textField.text as NSString).doubleValue)
        let now = NSDate()
        let sample = HKQuantitySample(type: weightQuantityType,
            quantity: weightQuantity,
            startDate: now,
            endDate: now)
        
        healthStore.saveObject(sample, withCompletion: {
            (succeeded: Bool, error: NSError?) in
            
            if error == nil{
                print("Successfully saved the user's weight")
            } else {
                print("Failed to save the user's weight")
            }
            
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

