//
//  AddHomeViewController.swift
//  Managing the User's Home
//
//  Created by Domenico Solazzo on 09/05/15.
//  License MIT
//

import UIKit
import HomeKit

class AddHomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField:UITextField!
    var homeManager: HMHomeManager!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    @IBAction func addHome(){
        if count(textField.text) == 0{
            displayAlertWithTitle("Home name", message: "Please enter the home name")
            return
        }
        // Add the home to the Home Manager
        homeManager.addHomeWithName(textField.text, completionHandler: {[weak self]
            (home:HMHome!, error:NSError!) -> Void in
            let strongSelf = self!
            
            if error != nil{
                strongSelf.displayAlertWithTitle("Error", message: "\(error)")
            }else{
                strongSelf.navigationController?.popViewControllerAnimated(true)
            }
        })
    }
    
    //- MARK: Helpers
    func displayAlertWithTitle(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}
