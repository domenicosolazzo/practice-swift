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
            
        }
    }
}

