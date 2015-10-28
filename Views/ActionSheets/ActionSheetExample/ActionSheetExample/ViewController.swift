//
//  ViewController.swift
//  ActionSheetExample
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    // Controller
    var controller: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a new action sheet
        controller = UIAlertController(title: "My action sheet", message: "How do you want to send a message", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Creating the actions
        let actionViaEmail = UIAlertAction(title: "Via Email", style: UIAlertActionStyle.Default){ (action: UIAlertAction!) in
            print("Message sent by email")
        }
        let actionViaIMessage = UIAlertAction(title: "Via iMessage", style: UIAlertActionStyle.Default){ (action: UIAlertAction!) in
            print("Message sent by IMessage")
        }
        let actionDeleted = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default){ (action: UIAlertAction!) in
            print("Message deleted!")
        }
        
        // Connecting the actions to the controller
        controller!.addAction(actionViaEmail)
        controller!.addAction(actionViaIMessage)
        controller!.addAction(actionDeleted)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Presenting the actionSheet
        self.presentViewController(controller!, animated: true, completion: nil)
    }

    


}

