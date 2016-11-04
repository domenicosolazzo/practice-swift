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
        
        let firstNumber = 111
        let secondNumber = 222
        
        // Create the first NSBlockOperation
        let firstOperation = BlockOperation {[weak self] () -> Void in
            if let strongSelf = self{
                strongSelf.firstOperationEntry(firstNumber as AnyObject?)
            }
        }
        
        let secondOperation = BlockOperation {[weak self] () -> Void in
            if let strongSelf = self{
                strongSelf.secondOperationEntry(secondNumber as AnyObject?)
            }
        }
        
        // Creating a dependency between the two operations
        // secondOperation will finish before firstOperation
        firstOperation.addDependency(secondOperation)
        
        // Create a queeu
        let queue = OperationQueue()
        queue.addOperation(firstOperation)
        queue.addOperation(secondOperation)
        
        print("Main thread is here")
    }
    
    //- MARK: Helpers
    // Perform the actual work
    func performWorkForParameter(_ param: AnyObject?, operationName: String){
        if let theParam: AnyObject = param{
            print("First operation - Object = \(theParam)")
        }
        
        print("\(operationName) Operation - " +
            "Main Thread = \(Thread.main)")
        
        print("\(operationName) Operation - " +
            "Current Thread = \(Thread.current)")
    }
    
    func firstOperationEntry(_ param: AnyObject?){
        performWorkForParameter(param, operationName: "First")
    }
    
    func secondOperationEntry(_ param: AnyObject?){
        
        performWorkForParameter(param, operationName: "Second")
        
    }

}

