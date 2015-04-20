//
//  SwitchingViewController.swift
//  ViewSwitcher
//
//  Created by Domenico on 19.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {

    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of BlueViewController
        blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue")
        blueViewController.view.frame = view.frame
        /// Switching the current view using the helper method
        switchViewController(from: nil, to: blueViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem){
        
    }

}
