//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Pasan Premaratne on 3/3/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    enum Error: Error {
        case noName
    }

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            do {
                if let name = nameTextField.text {
                    if name == "" {
                        throw Error.noName
                    }
                    if let pageController = segue.destination as? PageController {
                        pageController.page = Adventure.story(name)
                    }
                    
                }
            } catch Error.noName {
              let alertController = UIAlertController(title: "Name Not Provided", message: "Provide a name to start your story!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                
                present(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error)")
            }
            
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let userInfoDict = (notification as NSNotification).userInfo, let keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.cgRectValue
            
            UIView.animate(withDuration: 0.8, animations: {
                self.textFieldBottomConstraint.constant = keyboardFrame.size.height + 10
                self.view.layoutIfNeeded()
            }) 
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.8, animations: {
            self.textFieldBottomConstraint.constant = 40.0
            self.view.layoutIfNeeded()
        }) 
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}











