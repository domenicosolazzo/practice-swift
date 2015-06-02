//
//  SuperDBDateCell.swift
//  SuperDB
//
//  Created by Domenico on 01/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

let __dateFormatter = NSDateFormatter()

class SuperDBDateCell: SuperDBEditCell {

    private var datePicker: UIDatePicker!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        __dateFormatter.dateStyle = .MediumStyle
        
        self.textField.clearButtonMode = .Never
        self.datePicker = UIDatePicker(frame: CGRectZero)
        self.datePicker.datePickerMode = .Date
        self.datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
        self.textField.inputView = self.datePicker
    }
    
    //MARK: - SuperDBEditCell Overrides
    override var value:AnyObject! {
        get{
            if self.textField.text == nil || count(self.textField.text) == 0 {
                return nil
            } else {
                return self.datePicker.date as NSDate!
            }
        }
        set{
            if let _value = newValue as? NSDate {
                self.datePicker.date = _value
                self.textField.text = __dateFormatter.stringFromDate(_value)
            } else {
                self.textField.text = nil
            }
        }
    }
    
    
}
