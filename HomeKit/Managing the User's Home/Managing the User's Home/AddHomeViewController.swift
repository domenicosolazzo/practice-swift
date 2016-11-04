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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    @IBAction func addHome(){
        if textField.text?.characters.count == 0{
            displayAlertWithTitle("Home name", message: "Please enter the home name")
            return
        }
        // Add the home to the Home Manager
        homeManager.addHome(withName: textField.text!, completionHandler: {[weak self]
            (home:HMHome!, error:NSError!) -> Void in
            let strongSelf = self!
            
            if error != nil{
                strongSelf.displayAlertWithTitle("Error", message: "\(error)")
            }else{
                strongSelf.navigationController?.popViewController(animated: true)
            }
        } as! (HMHome?, Error?) -> Void)
    }
    
    //- MARK: Helpers
    func displayAlertWithTitle(_ title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}
