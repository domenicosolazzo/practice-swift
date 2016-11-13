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
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter the text to share..."
        textField.delegate = self
        self.view.addSubview(textField)
    }
    
    func createButton(){
        buttonShare = UIButton(type: UIButtonType.system) as UIButton
        buttonShare.frame = CGRect(x: 20, y: 80, width: 280, height: 44)
        buttonShare.setTitle("Share", for: UIControlState())
        buttonShare.addTarget(self,
            action: #selector(ViewController.handleShare(_:)),
            for: UIControlEvents.touchUpInside)
        self.view.addSubview(buttonShare)
    }
    
    //- MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //- MARK: UIButton
    func handleShare(_ sender: UIButton){
        if (textField.text!.isEmpty){
            let message = "Please enter a text and then click Share"
            let alert = UIAlertController(title: nil,
                message: message,
                preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(
                UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.default,
                    handler: nil)
            )
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        /* it is VERY important to cast your strings to NSString
        otherwise the controller cannot display 
        the appropriate sharing options */
        let activityController = UIActivityViewController(
            activityItems: [textField.text! as NSString],
            applicationActivities: nil
        )
        present(activityController,
            animated: true,
            completion: nil
        )
    }
}

