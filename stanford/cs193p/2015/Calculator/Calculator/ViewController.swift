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
        let operation = sender.currentTitle!
        if(userIsDigitingNumber){
            enter()
        }
        
        switch operation{
            case "+": performOperation(){$0 + $1}
            case "−": performOperation(){$1 - $0}
            case "×":performOperation(){$0 * $1}
            case "÷":performOperation(){$1 / $0}
            case "√":performOperation(){sqrt($0)}
            default: break;
        }
    }
    
    func performOperation(operation:(Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation:(Double) -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        operandStack.append(displayValue)
        userIsDigitingNumber = false
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

