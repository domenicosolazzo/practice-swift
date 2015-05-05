//
//  ViewController.swift
//  Custom Activity
//
//  Created by Domenico Solazzo on 05/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let itemsToShare = [
            "Item 1" as NSString,
            "Item 2" as NSString,
            "Item 3" as NSString
        ]
        
        let activityController = UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities:[StringReverserActivity()])
        
        presentViewController(activityController, animated: true, completion: nil)
    }
}

