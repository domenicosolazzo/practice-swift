//
//  SecondViewController.swift
//  TodoList

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var txtTask: UITextField
    @IBOutlet var txtDesc: UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTask_Click(sender: UIButton) {
        taskManager.addTask(txtTask.text, txtDesc.text)
        self.view.endEditing(true)
    }
    //
    // I want to remove the keyboard when the user touch outside the keyboard
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!){
        self.view.endEditing(true)
        
        // Clean up the text fields
        txtTask.text = ""
        txtDesc.text = ""
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

