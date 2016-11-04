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

   let database = CKContainer.default().privateCloudDatabase
    
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
    func carWithType(_ type: CarType) -> CKRecord{
        let uuid = UUID().uuidString
        let recordId = CKRecordID(recordName: uuid, zoneID: type.zoneId())
        let car = CKRecord(recordType: "MyCar", recordID: recordId)
        return car
    }
    
    func carWithType(_ type: CarType,
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
    
    func hatchbackCarWithMaker(_ maker: String,
        model: String,
        numberOfDoors: Int,
        year: Int) -> CKRecord{
            return carWithType(.Hatchback,
                maker: maker,
                model: model,
                numberOfDoors: numberOfDoors,
                year: year)
    }
    
    func estateCarWithMaker(_ maker: String,
        model: String,
        numberOfDoors: Int,
        year: Int) -> CKRecord{
            return carWithType(.Estate,
                maker: maker,
                model: model,
                numberOfDoors: numberOfDoors,
                year: year)
    }
    
    func saveCarClosure(_ record: CKRecord?, error: NSError?){
        
        /* Be careful, we might be on a non-UI thread */
        
        if error != nil{
            print("Failed to save the car. Error = \(error)")
        } else {
            print("Successfully saved the car with type \(record!.recordType)")
        }
        
    }
    
    func saveCars(_ cars: [CKRecord]){
        for car in cars{
            
            database.save(car, completionHandler: saveCarClosure as! (CKRecord?, Error?) -> Void)
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
        
        print("Saving estate cars...")
        saveCars([volvoV50, audiA6, skodaOctavia])
        
    }
    
    func saveHatchbackCars(){
        
        let fordFocus = hatchbackCarWithMaker("Ford",
            model: "Focus",
            numberOfDoors: 6,
            year: 2018)
        
        print("Saving hatchback cars...")
        saveCars([fordFocus])
        
    }
    
    func saveCarsForType(_ type: CarType){
        switch type{
        case .Hatchback:
            saveHatchbackCars()
        case .Estate:
            saveEstateCars()
        default:
            print("Unknown car state is given")
        }
    }
    
    func performOnMainThread(_ block: @escaping ()->()){
        DispatchQueue.main.async(execute: block)
    }
    
    // Create a new record zone or fetch the existing one
    func useOrSaveZone(zoneIsCreatedAlready: Bool, forCarType: CarType){
        
        if zoneIsCreatedAlready{
            print("Found the \(forCarType.rawValue) zone. " +
                "It's been created already")
            saveCarsForType(forCarType)
        } else {
            database.save(forCarType.zone(),
                completionHandler: {[weak self]
                    (zone: CKRecordZone?, error: NSError?) in
                    if error != nil{
                        print("Could not save the hatchback zone. Error = \(error)")
                    } else {
                        print("Successfully saved the hatchback zone")
                        self!.performOnMainThread{self!.saveCarsForType(forCarType)}
                    }
                } as! (CKRecordZone?, Error?) -> Void)
        }
        
    }
    
    func isIcloudAvailable() -> Bool{
        if let _ = FileManager.default.ubiquityIdentityToken{
            return true
        } else {
            return false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isIcloudAvailable(){
            displayAlertWithTitle("iCloud", message: "iCloud is not available." +
                " Please sign into your iCloud account and restart this app")
            return
        }
        
        database.fetchAllRecordZones{[weak self]
            (zones:[CKRecordZone]?, error: Error?) -> Void in
            
            if error != nil{
                print("Could not retrieve the zones")
            } else {
                
                var foundEstateZone = false
                var foundHatchbackZone = false
                
                for zone in zones! {
                    
                    if zone.zoneID.zoneName == CarType.Hatchback.rawValue{
                        foundHatchbackZone = true
                    }
                    else if zone.zoneID.zoneName == CarType.Estate.rawValue{
                        foundEstateZone = true
                    }
                }
                
                self!.useOrSaveZone(zoneIsCreatedAlready: foundEstateZone,
                    forCarType: .Estate)
                
                self!.useOrSaveZone(zoneIsCreatedAlready: foundHatchbackZone,
                    forCarType: .Hatchback)
                
            }
            
        } 
        
    }
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(_ title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .default,
            handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
}

