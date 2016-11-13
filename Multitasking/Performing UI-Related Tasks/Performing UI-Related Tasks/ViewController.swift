//
//  ViewController.swift
//  Performing UI-Related Tasks
//
//  Created by Domenico Solazzo on 12/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async(execute: {[weak self] in
            print("Current thread: \(Thread.current)")
            print("Main thread: \(Thread.main)")
            
            let alertController = UIAlertController(
                title: "GCD",
                message: "GCD is amazing",
                preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self!.present(alertController, animated: true, completion: nil)
        })
    }
}

