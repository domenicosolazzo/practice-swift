//
//  ViewController.swift
//  Performing a task only once
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    // Token used from the dispatch_one method to detect if a block of code
    // as been already executed
    var token: dispatch_once_t = 0
    
    var numberOfEntries = 0
    
    func executedOnlyOnce(){
        numberOfEntries++
        println("This code is executed only once. Entries: \(numberOfEntries)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        dispatch_once(&token, executedOnlyOnce)
        dispatch_once(&token, executedOnlyOnce) // It will not be executed
    }
}

