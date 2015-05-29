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
}

