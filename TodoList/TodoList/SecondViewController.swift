//
//  SecondViewController.swift
//  TodoList

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITextFieldDelegate
    // // called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        // Resign First Responder: In this context, the first responder is the keyboard.
        // Resigning the first responder, the keyboard should go away
        textField.resignFirstResponder()
        return true
    }
}

