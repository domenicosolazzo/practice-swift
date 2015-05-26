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
        // Which properties of each contact the user can see in the people picker
        personPicker.displayedProperties = [
            Int(kABPersonAddressProperty),
            Int(kABPersonPhoneProperty)
        ]
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
        
        /* Do we know which picker this is? */
        if peoplePicker != personPicker{
            return
        }
        
        let phones: ABMultiValueRef = ABRecordCopyValue(person,
            kABPersonPhoneProperty).takeRetainedValue() // If you want emails, use kABPersonEmailProperty
        let countOfPhones =  ABMultiValueGetCount(phones)
        
        for index in 0..<countOfPhones{
            let phone = ABMultiValueCopyValueAtIndex(phones,
                index).takeRetainedValue() as! String
            
            println(phone)
            
        }
        
        // If selected an address
        let addresses: ABMultiValueRef = ABRecordCopyValue(person,
            property).takeRetainedValue()
        
        let index = Int(identifier) as CFIndex
        
        let address: NSDictionary = ABMultiValueCopyValueAtIndex(addresses,
            index).takeRetainedValue() as! NSDictionary
        
        let country = address[kABPersonAddressCountryKey as String] as! String
        let city = address[kABPersonAddressCityKey as String] as! String
        let street = address[kABPersonAddressStreetKey as String] as! String
        
        println("Country = \(country)")
        println("City = \(city)")
        println("Street = \(street)")
    }
    
    @IBAction func performPickPerson(sender: UIButton) {
        self.presentViewController(personPicker, animated: true, completion: nil)
    }
}

