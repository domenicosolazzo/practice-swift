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
    }
    
    func createTextField(){
        textField = UITextField(frame:
            CGRect(x: 20, y: 35, width: 280, height: 30))
        textField.borderStyle = .RoundedRect
        textField.placeholder = "Enter the text to share..."
        textField.delegate = self
        self.view.addSubview(textField)
    }
    
    //- MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

