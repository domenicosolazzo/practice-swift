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
}
