//
//  CountingOperation.swift
//  Creating simple concurrency using Operations
//
//  Created by Domenico Solazzo on 13/05/15.
//  License MIT
//

import UIKit

class CountingOperation: Operation {
    // Private variables
    var startingCount:Int = 0
    var endingCount:Int = 0
    
    //- MARK: Initialization
    init(start:Int, end:Int){
        startingCount = start
        endingCount = end
    }
    
    convenience override init(){
        self.init(start:0, end:3)
    }
    
    override func main() {
        var isTaskFinished = false
        
        if isTaskFinished == false &&
            self.isFinished == false{
                for i in startingCount..<endingCount{
                    print("Printing the number \(i)")
                    print("Current Thread: \(Thread.current)")
                    print("Main Thread: \(Thread.main)")
                    print("---=================================---")
                }
                isTaskFinished = true
        }
    }
}
