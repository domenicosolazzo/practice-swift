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
    
    func saveEstateCars(){
        
        let volvoV50 = estateCarWithMaker("Volvo",
            model: "V50",
            numberOfDoors: 5,
            year: 2016)
        
        let audiA6 = estateCarWithMaker("Audi",
            model: "A6",
            numberOfDoors: 5,
            year: 2018)
        
        let skodaOctavia = estateCarWithMaker("Skoda",
            model: "Octavia",
            numberOfDoors: 5,
            year: 2016)
        
        println("Saving estate cars...")
        saveCars([volvoV50, audiA6, skodaOctavia])
        
    }
    
    func saveHatchbackCars(){
        
        let fordFocus = hatchbackCarWithMaker("Ford",
            model: "Focus",
            numberOfDoors: 6,
            year: 2018)
        
        println("Saving hatchback cars...")
        saveCars([fordFocus])
        
    }
    
    func saveCarsForType(type: CarType){
        switch type{
        case .Hatchback:
            saveHatchbackCars()
        case .Estate:
            saveEstateCars()
        default:
            println("Unknown car state is given")
        }
    }
    
    func performOnMainThread(block: dispatch_block_t){
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    // Create a new record zone or fetch the existing one
    func useOrSaveZone(#zoneIsCreatedAlready: Bool, forCarType: CarType){
        
        if zoneIsCreatedAlready{
            println("Found the \(forCarType.rawValue) zone. " +
                "It's been created already")
            saveCarsForType(forCarType)
        } else {
            database.saveRecordZone(forCarType.zone(),
                completionHandler: {[weak self]
                    (zone: CKRecordZone!, error: NSError!) in
                    if error != nil{
                        println("Could not save the hatchback zone. Error = \(error)")
                    } else {
                        println("Successfully saved the hatchback zone")
                        self!.performOnMainThread{self!.saveCarsForType(forCarType)}
                    }
                })
        }
        
    }
    
}

