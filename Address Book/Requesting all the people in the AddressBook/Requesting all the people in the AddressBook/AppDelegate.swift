//
//  AppDelegate.swift
//  Requesting all the people in the AddressBook
//
//  Created by Domenico on 26/05/15.
//  License MIT
//

import UIKit
import AddressBook

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var addressBook: ABAddressBookRef?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            print("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            self.readFromAddressBook(addressBook!)
        case .Denied:
            print("You are denied access to address book")
            
        case .NotDetermined:
            createAddressBook()
            if let theBook: ABAddressBookRef = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                    {(granted: Bool, error: CFError!) in
                        
                        if granted{
                            print("Access is granted")
                        } else {
                            print("Access is not granted")
                        }
                        
                })
            }
            
        case .Restricted:
            print("Access is restricted")
            
        default:
            print("Unhandled")
        }
        
        return true
    }
    
    func readFromAddressBook(addressBook: ABAddressBookRef){
        
        /* Get all the people in the address book */
        let allPeople = ABAddressBookCopyArrayOfAllPeople(
            addressBook).takeRetainedValue() as NSArray
        
        for person: ABRecordRef in allPeople{
            
            let firstName = ABRecordCopyValue(person,
                kABPersonFirstNameProperty).takeRetainedValue() as! String
            
            let lastName = ABRecordCopyValue(person,
                kABPersonLastNameProperty).takeRetainedValue()as! String
            
            
            print("First name = \(firstName)")
            print("Last name = \(lastName)")
            self.readEmailsForPerson(person)
        }
        
    }
    
    func readEmailsForPerson(person: ABRecordRef){
        
        let emails: ABMultiValueRef = ABRecordCopyValue(person,
            kABPersonEmailProperty).takeRetainedValue()
        
        for counter in 0..<ABMultiValueGetCount(emails){
            
            let email = ABMultiValueCopyValueAtIndex(emails,
                counter).takeRetainedValue() as! String
            
            print(email)
            
        }
        
    }
    
    func createAddressBook(){
        var error: Unmanaged<CFError>?
        
        addressBook = ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue()
        
        /* You can use the address book here */
        func createAddressBook(){
            var error: Unmanaged<CFError>?
            
            addressBook = ABAddressBookCreateWithOptions(nil,
                &error).takeRetainedValue()
            
            /* You can use the address book here */
            self.readFromAddressBook(addressBook!)
            
        }
    }

}

