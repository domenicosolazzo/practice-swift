//
//  SuperDBEditCell.swift
//  SuperDB
//
//  Created by Domenico on 01/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import CoreData

class SuperDBEditCell: UITableViewCell, UITextFieldDelegate {

    var label: UILabel!
    var textField: UITextField!
    let kLabelTextColor = UIColor(red: 0.321569, green: 0.4, blue: 0.568627, alpha: 1)
    var key: String!
    var hero: NSManagedObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textField.delegate = self
        
        self.selectionStyle = .None
        
        self.label = UILabel(frame: CGRectMake(12, 15, 67, 15))
        self.label.backgroundColor = UIColor.clearColor()
        self.label.font = UIFont.boldSystemFontOfSize(UIFont.smallSystemFontSize())
        self.label.textColor = kLabelTextColor
        self.label.text = "label"
        self.contentView.addSubview(self.label)
        
        self.textField = UITextField(frame: CGRectMake(93, 13, 170, 19))
        self.textField.backgroundColor = UIColor.clearColor()
        self.textField.clearButtonMode = .WhileEditing
        self.textField.enabled = false
        self.textField.font = UIFont.boldSystemFontOfSize(UIFont.systemFontSize())
        self.textField.text = "Title"
        self.contentView.addSubview(self.textField)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.textField.enabled = editing
    }
    
    //MARK: - Property Overrides
    var value: AnyObject! {
        get{
            return self.textField.text as String
        }
        
        set {
            self.textField.text = newValue as? String
        }
    }
    
    //MARK: - Instance Methods
    @IBAction func validate(){
        var val: AnyObject? = self.value
        var error: NSError?
        if !self.hero.validateValue(&val, forKey: self.key, error: &error) {
            var message: String!
            if error?.domain == "NSCocoaErrorDomain" {
                var userInfo:NSDictionary? = error?.userInfo
                var errorKey = userInfo?.valueForKey("NSValidationErrorKey") as! String
                var reason = error?.localizedFailureReason
                message = NSLocalizedString("Validation error on \(errorKey)\rFailure Reason: \(reason)",
                    comment: "Validation error on \(errorKey)\rFailure Reason: \(reason)")
            } else {
                message = error?.localizedDescription
            }
            var title = NSLocalizedString("Validation Error",
                comment: "Validation Error")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let fixAction = UIAlertAction(title: "Fix", style: .Default, handler: {
                _ in
                var result = self.textField.becomeFirstResponder()
            })
            alert.addAction(fixAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){[weak self] _ in
                self!.setValue(self!.hero.valueForKey(self!.key)!)
            }
            alert.addAction(cancelAction)
            
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(
                alert, animated: true, completion: nil)
        }
    }

    func setValue(aValue:AnyObject){
        if let _aValue = aValue as? NSString{
            self.textField.text = _aValue as String
        } else {
            self.textField.text = aValue.description
        }
    }
    //MARK: - UITextFieldDelegate Methods
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.validate()
    }
    

}
