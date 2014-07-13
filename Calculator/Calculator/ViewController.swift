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
    
    @IBOutlet var operationTextView: UITextView
    var operation: String = ""
    var accumulator:Double? = nil
    var isResult = false
    var firstOperand:Double?
    var secondOperand:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Reset the calculator
    @IBAction func resetResult(sender: UIButton?) {
        isResult = false
        firstOperand = nil
        secondOperand = nil
        resultTextView.text = ""
    }
    // Memory operations
    @IBAction func MemoryOperationPressed(sender: UIButton) {
    }

    // Prefix pressed
    @IBAction func prefixPressed(sender: UIButton) {
        if resultTextView.text.isEmpty || resultTextView.text == "0" || resultTextView.text == "ERROR!"{
            resultTextView.text = "0"
            return
        }
        
        var result = resultTextView.text as NSString
        if(result.containsString("-") ){
            resultTextView.text = result.substringFromIndex(1)
        }else{
            resultTextView.text = "-" + resultTextView.text
        }
    }
    
    // The operation has been pressed
    @IBAction func pressedOperation(sender: UIButton) {
        var op = sender.titleLabel.text
        
        operation = op
        operationTextView.text = operation
        
        var temp:Double = 0
        if(!resultTextView.text.isEmpty){
            temp = (resultTextView.text as NSString).doubleValue
        }else{
            return;
        }
        
        if(firstOperand){
            secondOperand = temp
            
        }else{
            firstOperand = temp
        }
        resultTextView.text = ""
    }
    
    // Calculate the result
    @IBAction func calculateResult(sender: UIButton?) {
        
        if(secondOperand || !resultTextView.text.isEmpty){
            secondOperand = (resultTextView.text as NSString).doubleValue
        }
        if(firstOperand && secondOperand){
            var temp = firstOperand!
            var temp2 = secondOperand!
            println("First:\(temp), second: \(temp2)")
            var res:Double = 0
        
            switch(operation){
                case "+":
                    res = temp + temp2
                case "-":
                    res = temp - temp2
                case "x":
                    res = temp * temp2
                case "/":
                    if temp2 == 0{
                        showError()
                        return
                    }
                    res = temp/temp2
                default:
                    showError()
            }
            println("Res:\(res)")
            
            firstOperand = res
            showResult(res)
            
        }else{
            resultTextView.text = ""
        }
    }
    
    // The dot button has been pressed
    @IBAction func dotPressed(sender: UIButton) {
        var dot = "."
        
        if resultTextView.text.isEmpty || resultTextView.text == "ERROR!"{
            resultTextView.text = "0"
        }
        
        var result = resultTextView.text as NSString
        if(!result.containsString(dot) ){
            resultTextView.text = resultTextView.text + dot
        }
    }
    
    // The number has been pressed
    @IBAction func numberPressed(sender: UIButton) {
        if(resultTextView.text == "0" || resultTextView.text == "ERROR!" || isResult){
            resultTextView.text = sender.titleLabel.text
        }else{
            resultTextView.text = resultTextView.text + sender.titleLabel.text
        }
    }
    
    func showResult(result: Double){
        resultTextView.text = "\(result)"
        isResult = true
    }
    
    func showError(){
        resetResult(nil)
        resultTextView.text = "ERROR!"
    }
}

