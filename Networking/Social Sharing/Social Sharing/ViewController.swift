//
//  ViewController.swift
//  Social Sharing
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit
import Social

class ViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let serviceType = SLServiceTypeTwitter
        
        if SLComposeViewController.isAvailableForServiceType(serviceType){
            let controller = SLComposeViewController(forServiceType: serviceType)
            // Set the initial text
            controller.setInitialText("Testing #swift social framework! #coding #dev")
            // Add the image
            controller.addImage("swift")
            // Add an url
            controller.addURL(NSURL(string: "http://goo.gl/cEnUaQ"))
            // Completion Handler
            controller.completionHandler = {(result: SLComposeViewControllerResult) in
                println("Completed")
                println("Result: \(result)")
            }
            
            self.presentViewController(controller, animated: true, completion: nil)
        }else{
            println("Twitter service is not available")
        }
    }
}

