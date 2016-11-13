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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let serviceType = SLServiceTypeTwitter
        
        if SLComposeViewController.isAvailable(forServiceType: serviceType){
            let controller = SLComposeViewController(forServiceType: serviceType)
            // Set the initial text
            controller?.setInitialText("Testing #swift social framework! #coding #dev")
            // Add the image
            controller?.add(UIImage(named: "swift"))
            // Add an url
            controller?.add(URL(string: "http://goo.gl/cEnUaQ"))
            // Completion Handler
            controller?.completionHandler = {(result: SLComposeViewControllerResult) in
                print("Completed")
                print("Result: \(result)")
            }
            
            self.present(controller!, animated: true, completion: nil)
        }else{
            print("Twitter service is not available")
        }
    }
}

