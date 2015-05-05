//
//  ViewController.swift
//  ActivityViewController Example
//
//  Created by Domenico Solazzo on 05/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var textField: UITextField!
    var buttonShare: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTextField()
        self.createButton()
    }
    
    func createTextField(){
        textField = UITextField(frame:
            CGRect(x: 20, y: 35, width: 280, height: 30))
        textField.borderStyle = .RoundedRect
        textField.placeholder = "Enter the text to share..."
        textField.delegate = self
        self.view.addSubview(textField)
    }
    
    func createButton(){
        buttonShare = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        buttonShare.frame = CGRect(x: 20, y: 80, width: 280, height: 44)
        buttonShare.setTitle("Share", forState: UIControlState.Normal)
        buttonShare.addTarget(self,
            action: "handleShare:",
            forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonShare)
    }
    
    //- MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //- MARK: UIButton
    func handleShare(sender: UIButton){
        if (textField.text.isEmpty){
            var message = "Please enter a text and then click Share"
            var alert = UIAlertController(title: nil,
                message: message,
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(
                UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: nil)
            )
            
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        /* it is VERY important to cast your strings to NSString
        otherwise the controller cannot display 
        the appropriate sharing options */
        var activityController = UIActivityViewController(
            activityItems: [textField.text as NSString],
            applicationActivities: nil
        )
        presentViewController(activityController,
            animated: true,
            completion: nil
        )
    }
}

