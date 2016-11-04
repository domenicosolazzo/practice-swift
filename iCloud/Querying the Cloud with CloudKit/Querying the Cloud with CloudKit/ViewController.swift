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

    let database = CKContainer.default().privateCloudDatabase
    lazy var operationQueue = OperationQueue()
    
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
        if FileManager.default.ubiquityIdentityToken != nil{
            return true
        } else {
            return false
        }
    }
    
    func recordFetchBlock(_ record: CKRecord!){
        
        print("Fetched a record = \(record)")
        
    }
    
    func completionBlock(cursor: CKQueryCursor?, error: NSError?) -> Void?{
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isIcloudAvailable(){
            displayAlertWithTitle("iCloud", message: "iCloud is not available." +
                " Please sign into your iCloud account and restart this app")
            return
        }
        
        let makerToLookFor = "Volvo"
        let smallestYearToLookFor = 2013
        
        let predicate = NSPredicate(format: "maker = %@ AND year >= %@",
            makerToLookFor, NSNumber(value: smallestYearToLookFor as Int))
        
        let query = CKQuery(recordType: "MyCar", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.recordFetchedBlock = recordFetchBlock
        operation.queryCompletionBlock = {[weak self]
            (cursor: CKQueryCursor?, error: NSError?) -> Void in
            if cursor != nil{
                /* There is so much data that a cursor came back to us and we will
                need to fetch the rest of the results in a separate operation */
                print("A cursor was sent to us. Fetching the rest of the records...")
                let newOperation = CKQueryOperation(cursor: cursor)
                newOperation.recordFetchedBlock = self!.recordFetchBlock
                newOperation.queryCompletionBlock = operation.queryCompletionBlock
                self!.operationQueue.addOperation(newOperation)
            } else {
                print("No cursor came back. We've fetched all the data")
            }
        }
        
        operationQueue.addOperation(operation)
        
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

