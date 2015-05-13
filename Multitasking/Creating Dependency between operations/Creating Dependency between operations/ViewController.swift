//
//  ViewController.swift
//  Creating Dependency between operations
//
//  Created by Domenico Solazzo on 13/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var firstNumber = 111
        var secondNumber = 222
        
        // Create the first NSBlockOperation
        let firstOperation = NSBlockOperation {[weak self] () -> Void in
            if let strongSelf = self{
                strongSelf.firstOperationEntry(firstNumber)
            }
        }
        
        let secondOperation = NSBlockOperation {[weak self] () -> Void in
            if let strongSelf = self{
                strongSelf.secondOperationEntry(secondNumber)
            }
        }
        
        // Creating a dependency between the two operations
        // secondOperation will finish before firstOperation
        firstOperation.addDependency(secondOperation)
        
        // Create a queeu
        let queue = NSOperationQueue()
        queue.addOperation(firstOperation)
        queue.addOperation(secondOperation)
        
        println("Main thread is here")
    }
    
    //- MARK: Helpers
    // Perform the actual work
    func performWorkForParameter(param: AnyObject?, operationName: String){
        if let theParam: AnyObject = param{
            println("First operation - Object = \(theParam)")
        }
        
        println("\(operationName) Operation - " +
            "Main Thread = \(NSThread.mainThread())")
        
        println("\(operationName) Operation - " +
            "Current Thread = \(NSThread.currentThread())")
    }
    
    func firstOperationEntry(param: AnyObject?){
        performWorkForParameter(param, operationName: "First")
    }
    
    func secondOperationEntry(param: AnyObject?){
        
        performWorkForParameter(param, operationName: "Second")
        
    }

}

