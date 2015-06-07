//
//  ViewController.swift
//  CocoaPodsExample
//
//  Created by Domenico on 06/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let AFHTTPManager = AFHTTPRequestOperationManager()
        AFHTTPManager.GET(
            "http://sample.com/data.php",
            parameters: nil,
            success: {(operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("Data is : " + responseObject.description)
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!)in
                println("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

