//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by Domenico on 20.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let date = Date()
        datePicker.setDate(date, animated:false)
    }

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Fetch the date from the date picker
        let date = datePicker.date
        // Set a new message
        let message = "The date and time you selected is \(date)"
        
        // Create a new Alert
        let alert = UIAlertController(title: "Date and Time selected", message: message, preferredStyle: UIAlertControllerStyle.alert)
        // Create an alert action
        let action = UIAlertAction(title: "Clicked", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
