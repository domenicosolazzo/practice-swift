//
//  ViewController.swift
//  Querying the Cloud with CloudKit
//
//  Created by Domenico on 29/05/15.
//  License MIT
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    let database = CKContainer.defaultContainer().privateCloudDatabase
    lazy var operationQueue = NSOperationQueue()
    
    /* Defines our car types */
    enum CarType: String{
        case Estate = "Estate"
        
        func zoneId() -> CKRecordZoneID{
            let zoneId = CKRecordZoneID(zoneName: self.rawValue,
                ownerName: CKOwnerDefaultName)
            return zoneId
        }
        
    }
}

