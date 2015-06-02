//
//  SuperDBColorCell.swift
//  SuperDB
//
//  Created by Domenico on 02/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class SuperDBColorCell: SuperDBEditCell {

    var colorPicker: UIColorPicker!
    var attributedColorString: NSAttributedString!{
        get{
            var block = NSString(UTF8String: "\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}\u{2588}")
            var color:UIColor = self.colorPicker.color
            var attrs:NSDictionary = [
                NSForegroundColorAttributeName:color,
                NSFontAttributeName:UIFont.boldSystemFontOfSize(UIFont.systemFontSize())]
            var attributedString = NSAttributedString(string: block! as String, attributes:attrs as [NSObject : AnyObject])
            return attributedString
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.colorPicker = UIColorPicker(frame: CGRectMake(0, 0, 320, 216))
        self.colorPicker.addTarget(self, action: "colorPickerChanged:", forControlEvents: .ValueChanged)
        self.textField.inputView = self.colorPicker
    }
    
    //MARK: - SuperDBEditCell Overrides
    
    override var value: AnyObject!{
        get{
            return self.colorPicker.color
        }
        set{
            if let _color = newValue as? UIColor {
                self.setValue(newValue)
                self.colorPicker.color = newValue as! UIColor
            } else {
                self.colorPicker.color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            }
            self.textField.attributedText = self.attributedColorString
        }
    }
    
    func colorPickerChanged(sender: AnyObject){
        self.textField.attributedText = self.attributedColorString
    }

}
