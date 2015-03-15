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

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        display.text = display.text! + digit
    }
}

