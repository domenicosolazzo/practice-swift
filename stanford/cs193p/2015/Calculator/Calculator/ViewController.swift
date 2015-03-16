//
//  ViewController.swift
//  Calculator
//
//  Created by Domenico on 15.03.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsDigitingNumber: Bool = false
    var brain =  CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsDigitingNumber{
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsDigitingNumber = true
        }
    }
    @IBAction func operate(sender: UIButton) {
        if(userIsDigitingNumber){
            enter()
        }
        
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
    
    
    @IBAction func enter() {
        userIsDigitingNumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set{
            display.text = "\(newValue)"
            userIsDigitingNumber = false
        }
    }
}

