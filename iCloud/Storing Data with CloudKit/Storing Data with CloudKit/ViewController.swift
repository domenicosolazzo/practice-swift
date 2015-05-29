//
//  ViewController.swift
//  Storing Data with CloudKit
//
//  Created by Domenico on 29/05/15.
//  License MIT
//

import UIKit
import CloudKit

class ViewController: UIViewController {

   let database = CKContainer.defaultContainer().privateCloudDatabase
    
    enum CarType: String{
        case Hatchback = "Hatchback"
        case Estate = "Estate"
        
        func zoneId() -> CKRecordZoneID{
            let zoneId = CKRecordZoneID(zoneName: self.rawValue,
                ownerName: CKOwnerDefaultName)
            return zoneId
        }
        
        func zone() -> CKRecordZone{
            return CKRecordZone(zoneID: self.zoneId())
        }
        
    }
    
}

