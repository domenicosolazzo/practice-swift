//
//  ViewController.swift
//  DatePickerExample
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    // Date Picker
    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker!.center = self.view.center
        self.view.addSubview(datePicker!)
        
        // Add a target
        datePicker?.addTarget(self,
            action: "datePickerDateChanged:",
            forControlEvents: .ValueChanged)
    }
    
    // Fetch the current date
    func datePickerDateChanged(picker:UIDatePicker){
        println("Selected date: \(picker.date)")
    }
}

