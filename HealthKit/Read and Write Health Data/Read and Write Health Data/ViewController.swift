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
        textField.rightView = textFieldRightLabel
        textField.rightViewMode = .Always
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
            healthStore.requestAuthorizationToShareTypes(typesToShare,
                readTypes: typesToRead){[weak self](succeeded: Bool, error: NSError!) in
                
                let strongSelf = self!
                if succeeded && error == nil{
                    strongSelf.readWeightInformation()
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
    
    func readWeightInformation(){
        // Sorting. Descending.
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // Set the query
        let query = HKSampleQuery(sampleType: weightQuantity,
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
                    print("Could not read the user's weight ")
                    println("or no weight data was available")
                }
                
                
            })
        // Execute the query
        healthStore.executeQuery(query)
    }
}

