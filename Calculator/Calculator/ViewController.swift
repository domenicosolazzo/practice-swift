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

    @IBAction func MemoryOperationPressed(sender: UIButton) {
    }

    @IBAction func pressedOperation(sender: UIButton) {
        println(sender.titleLabel.text)
    }
    @IBAction func numberPressed(sender: UIButton) {
        if(resultTextView.text == "0"){
            resultTextView.text = sender.titleLabel.text
        }else{
            resultTextView.text = resultTextView.text + sender.titleLabel.text
        }
        
    }
}

