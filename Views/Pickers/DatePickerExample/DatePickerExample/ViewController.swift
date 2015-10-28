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
        
        // Limit the date time picker
        let oneYearTime:NSTimeInterval = 365 * 24 * 60 * 60
        let todayDate = NSDate()
        
        let oneYearFromToday = todayDate.dateByAddingTimeInterval(oneYearTime)
        
        let twoYearsFromToday = todayDate.dateByAddingTimeInterval(2 * oneYearTime)
        
        datePicker!.minimumDate = oneYearFromToday
        datePicker!.maximumDate = twoYearsFromToday
    }
    
    // Fetch the current date
    func datePickerDateChanged(picker:UIDatePicker){
        print("Selected date: \(picker.date)")
    }
}

