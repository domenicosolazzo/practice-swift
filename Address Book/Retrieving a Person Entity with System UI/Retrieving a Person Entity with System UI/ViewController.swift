//
//  ViewController.swift
//  Retrieving a Person Entity with System UI
//
//  Created by Domenico on 26/05/15.
//  License MIT
//

import UIKit
import AddressBookUI

class ViewController: UIViewController,
            ABPeoplePickerNavigationControllerDelegate{
    
    //- MARK: Private variables
    let personPicker: ABPeoplePickerNavigationController
    
    required init(coder aDecoder: NSCoder) {
        personPicker = ABPeoplePickerNavigationController()
        super.init(coder: aDecoder)
        personPicker.peoplePickerDelegate = self
    }
}

