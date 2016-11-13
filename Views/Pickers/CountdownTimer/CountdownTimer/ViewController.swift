//
//  ViewController.swift
//  CountdownTimer
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    // DatePicker
    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.center = self.view.center
        datePicker?.datePickerMode = UIDatePickerMode.countDownTimer
        
        let interval = (2 * 60) as TimeInterval
        datePicker?.countDownDuration = interval
        
        self.view.addSubview(datePicker!)
        
    }
}

