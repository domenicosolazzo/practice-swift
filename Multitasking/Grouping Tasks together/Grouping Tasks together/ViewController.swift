//
//  ViewController.swift
//  Grouping Tasks together
//
//  Created by Domenico Solazzo on 13/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    func reloadTableView(){
        /* Reload the table view here */
        print(#function)
    }
    
    func reloadScrollView(){
        /* Do the work here */
        print(#function)
    }
    
    func reloadImageView(){
        /* Reload the image view here */
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskGroup = DispatchGroup()
        let mainQueue = DispatchQueue.main
        
        // Reload the table view in the main queue
        mainQueue.async(group: taskGroup, execute: {[weak self] in
            self!.reloadTableView()
        })
        
        // Reload the scrollView in the main queue
        mainQueue.async(group: taskGroup, execute: {[weak self] in
            self!.reloadScrollView()
        })

        // Reload the ImageView in the main queue
        mainQueue.async(group: taskGroup, execute: {[weak self] in
            self!.reloadImageView()
        })
        
        /* When we are done, dispatch the following block */
        taskGroup.notify(queue: mainQueue, execute: {[weak self] in
            // Do some processing here
            
            let alertController = UIAlertController(title: "Task group", message: "We have finished all the operations in background", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(
                UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            )
            
            self!.present(alertController, animated: true, completion: nil)
        })
    }
}

