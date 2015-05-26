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
    
    //- MARK: Constructors
    required init(coder aDecoder: NSCoder) {
        personPicker = ABPeoplePickerNavigationController()
        super.init(coder: aDecoder)
        personPicker.peoplePickerDelegate = self
    }
    
    //-  MARK: ABPeoplePickerNavigationControllerDelegate
    // When the user cancel the action
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
        println("User cancelled the action...")
    }
    
    // When a contact has been selected
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        println("User selected a contact")
    }
}

