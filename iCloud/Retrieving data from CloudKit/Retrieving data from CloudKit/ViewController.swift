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
        if let token = NSFileManager.defaultManager().ubiquityIdentityToken{
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
            println("No record name was previously generated")
            println("Creating a new one...")
            recordName = NSUUID().UUIDString
            NSUserDefaults.standardUserDefaults().setValue(recordName, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        if let name = recordName{
            if count(name) == 0{
                createNewRecordName()
            } else {
                println("The previously generated record ID was recovered")
            }
        } else {
            createNewRecordName()
        }
        
        return CKRecordID(recordName: recordName, zoneID: CarType.Estate.zoneId())
        
    }
}

