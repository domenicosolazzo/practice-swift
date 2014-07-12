//
//  ViewController.swift
//  Calculator
//
//  Created by Domenico Solazzo on 7/12/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var resultTextView: UITextView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func MemoryOperationPressed(sender: AnyObject) {
    }

    @IBAction func pressedOperation(sender: AnyObject) {
    }
    @IBAction func numberPressed(sender: AnyObject) {
    }
}

