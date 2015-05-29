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
}

