//
//  SuperDBEditCell.swift
//  SuperDB
//
//  Created by Domenico on 01/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class SuperDBEditCell: UITableViewCell {

    var label: UILabel!
    var textField: UITextField!
    let kLabelTextColor = UIColor(red: 0.321569, green: 0.4, blue: 0.568627, alpha: 1)
    var key: String!
    
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

}
