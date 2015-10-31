//
//  ViewController.swift
//  Retrieving data from CloudKit
//
//  Created by Domenico on 29/05/15.
//  License MIT
//

import UIKit
import CloudKit

class ViewController: UIViewController {
    let database = CKContainer.defaultContainer().privateCloudDatabase
    
    /* Defines our car types */
    enum CarType: String{
        case Estate = "Estate"
        
        func zoneId() -> CKRecordZoneID{
            let zoneId = CKRecordZoneID(zoneName: self.rawValue,
                ownerName: CKOwnerDefaultName)
            return zoneId
        }
        
    }
    
    /* Checks if the user has logged into her iCloud account or not */
    func isIcloudAvailable() -> Bool{
        if let _ = NSFileManager.defaultManager().ubiquityIdentityToken{
            return true
        } else {
            return false
        }
    }
    
    /* This method generates a record ID and keeps it in the system defaults
    so that the second time it is called, it will generate the exact same record
    ID like before which we can use to find the stored record in the database */
    func recordId() -> CKRecordID{
        
        /* The key into NSUserDefaults */
        let key = "recordId"
        
        var recordName =
        NSUserDefaults.standardUserDefaults().stringForKey(key)
        
        func createNewRecordName(){
            print("No record name was previously generated")
            print("Creating a new one...")
            recordName = NSUUID().UUIDString
            NSUserDefaults.standardUserDefaults().setValue(recordName, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        if let name = recordName{
            if name.characters.count == 0{
                createNewRecordName()
            } else {
                print("The previously generated record ID was recovered")
            }
        } else {
            createNewRecordName()
        }
        
        return CKRecordID(recordName: recordName!, zoneID: CarType.Estate.zoneId())
        
    }
    
    func saveRecordWithCompletionHandler(completionHandler:
        (succeeded: Bool, error: NSError!) -> Void){
            
            /* Store information about a Volvo V50 car */
            let volvoV50 = CKRecord(recordType: "MyCar", recordID: recordId())
            volvoV50.setObject("Volvo", forKey: "maker")
            volvoV50.setObject("V50", forKey: "model")
            volvoV50.setObject(5, forKey: "numberOfDoors")
            volvoV50.setObject(2015, forKey: "year")
            
            /* Save this record publicly */
            database.saveRecord(volvoV50, completionHandler: {
                (record: CKRecord?, error: NSError?) in
                completionHandler(succeeded: (error == nil), error: error)
            })
            
    }
    
    
      override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        if isIcloudAvailable(){
          displayAlertWithTitle("iCloud", message: "iCloud is not available." +
            " Please sign into your iCloud account and restart this app")
          return
        }
    
        print("Fetching the record to see if it exists already...")
    
        /* Attempt to find the record if we have saved it already */
        database.fetchRecordWithID(recordId(), completionHandler:{[weak self]
          (record: CKRecord?, error: NSError?) in
    
          if error != nil{
            print("An error occurred")
    
            if error!.code == CKErrorCode.UnknownItem.rawValue{
              print("This error means that the record was not found.")
              print("Saving the record...")
    
              self!.saveRecordWithCompletionHandler{
                (succeeded: Bool, error: NSError!) in
    
                if succeeded{
                  print("Successfully saved the record")
                } else {
                  print("Failed to save the record. Error = \(error)")
                }
    
              }
    
            } else {
              print("I don't understand this error. Error = \(error)")
            }
    
          } else {
            print("Seems like we had previously stored the record. Great!")
            print("Retrieved record = \(record)")
          }
    
          })
    
      }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
}

