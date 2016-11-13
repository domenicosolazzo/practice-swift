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
            action: #selector(ViewController.datePickerDateChanged(_:)),
            for: .valueChanged)
        
        // Limit the date time picker
        let oneYearTime:TimeInterval = 365 * 24 * 60 * 60
        let todayDate = Date()
        
        let oneYearFromToday = todayDate.addingTimeInterval(oneYearTime)
        
        let twoYearsFromToday = todayDate.addingTimeInterval(2 * oneYearTime)
        
        datePicker!.minimumDate = oneYearFromToday
        datePicker!.maximumDate = twoYearsFromToday
    }
    
    // Fetch the current date
    func datePickerDateChanged(_ picker:UIDatePicker){
        print("Selected date: \(picker.date)")
    }
}

