//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Domenico on 16.03.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import Foundation

class CalculatorBrain{
    enum Op{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    // Known operations
    var knownOps = [String:Op]()
    
    var opStack = [Op]()
    
    init(){
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷"){$1 / $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    func pushOperand(operand: Double){
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol:String){
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
    }
}
