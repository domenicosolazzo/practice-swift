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
        println(__FUNCTION__)
    }
    
    func reloadScrollView(){
        /* Do the work here */
        println(__FUNCTION__)
    }
    
    func reloadImageView(){
        /* Reload the image view here */
        println(__FUNCTION__)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskGroup = dispatch_group_create()
        let mainQueue = dispatch_get_main_queue()
        
        // Reload the table view in the main queue
        dispatch_group_async(taskGroup, mainQueue, {[weak self] in
            self!.reloadTableView()
        })
        
        // Reload the scrollView in the main queue
        dispatch_group_async(taskGroup, mainQueue, {[weak self] in
            self!.reloadScrollView()
        })

        // Reload the ImageView in the main queue
        dispatch_group_async(taskGroup, mainQueue, {[weak self] in
            self!.reloadImageView()
        })
        
        /* When we are done, dispatch the following block */
        dispatch_group_notify(taskGroup, mainQueue, {[weak self] in
            // Do some processing here
            
            let alertController = UIAlertController(title: "Task group", message: "We have finished all the operations in background", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(
                UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            )
            
            self!.presentViewController(alertController, animated: true, completion: nil)
        })
    }
}

