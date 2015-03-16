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
    private func evaluate(ops:[Op]) -> (result:Double?, remainingOps:[Op]){
        if(!ops.isEmpty){
            // Need this step because ops is immutable
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            
        }
        return (nil, ops)
    }
    func evaluate() -> Double?{
        return nil
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
