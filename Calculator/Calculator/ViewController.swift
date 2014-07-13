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
    
    var operation: String = ""
    var firstOperand: Int = 0
    var secondOperand: Int = 0
    var isMinusPrefix:Bool = false
    var isDecimalDot:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetResult(sender: UIButton) {
        resultTextView.text = ""
    }
    @IBAction func MemoryOperationPressed(sender: UIButton) {
    }

    @IBAction func prefixPressed(sender: UIButton) {
        isMinusPrefix = !isMinusPrefix
    }
    @IBAction func pressedOperation(sender: UIButton) {

        var op = sender.titleLabel.text
        operation = op
    }
    
    @IBAction func dotPressed(sender: UIButton) {
        var dot = "."
        var result = resultTextView.text as NSString
        if(!result.containsString(dot)){
            resultTextView.text = resultTextView.text + dot
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        if(resultTextView.text == "0"){
            resultTextView.text = sender.titleLabel.text
        }else{
            resultTextView.text = resultTextView.text + sender.titleLabel.text
        }
    }
}

