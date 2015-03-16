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
}
