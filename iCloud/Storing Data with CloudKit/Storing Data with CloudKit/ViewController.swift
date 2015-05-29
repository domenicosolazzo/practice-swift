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
    
    // Return a record that represents a car with type
    func carWithType(type: CarType) -> CKRecord{
        let uuid = NSUUID().UUIDString
        let recordId = CKRecordID(recordName: uuid, zoneID: type.zoneId())
        let car = CKRecord(recordType: "MyCar", recordID: recordId)
        return car
    }
    
    func carWithType(type: CarType,
        maker: String,
        model: String,
        numberOfDoors: Int,
        year: Int) -> CKRecord{
            
            let record = carWithType(type)
            
            record.setValue(maker, forKey: "maker")
            record.setValue(model, forKey: "model")
            record.setValue(numberOfDoors, forKey: "numberOfDoors")
            record.setValue(year, forKey: "year")
            
            return record
            
    }
    
    func hatchbackCarWithMaker(maker: String,
        model: String,
        numberOfDoors: Int,
        year: Int) -> CKRecord{
            return carWithType(.Hatchback,
                maker: maker,
                model: model,
                numberOfDoors: numberOfDoors,
                year: year)
    }
    
    func estateCarWithMaker(maker: String,
        model: String,
        numberOfDoors: Int,
        year: Int) -> CKRecord{
            return carWithType(.Estate,
                maker: maker,
                model: model,
                numberOfDoors: numberOfDoors,
                year: year)
    }
    
    func saveCarClosure(record: CKRecord!, error: NSError!){
        
        /* Be careful, we might be on a non-UI thread */
        
        if error != nil{
            println("Failed to save the car. Error = \(error)")
        } else {
            println("Successfully saved the car with type \(record.recordType)")
        }
        
    }
    
    func saveCars(cars: [CKRecord]){
        for car in cars{
            database.saveRecord(car, completionHandler: saveCarClosure)
        }
    }
    
}

