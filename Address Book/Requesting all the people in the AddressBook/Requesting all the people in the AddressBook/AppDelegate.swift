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

    var addressBook: ABAddressBook?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .authorized:
            print("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            self.readFromAddressBook(addressBook!)
        case .denied:
            print("You are denied access to address book")
            
        case .notDetermined:
            createAddressBook()
            if let theBook: ABAddressBook = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                    {(granted: Bool, error: CFError?) in
                        
                        if granted{
                            print("Access is granted")
                        } else {
                            print("Access is not granted")
                        }
                        
                })
            }
            
        case .restricted:
            print("Access is restricted")
            
        default:
            print("Unhandled")
        }
        
        return true
    }
    
    func readFromAddressBook(_ addressBook: ABAddressBook){
        
        /* Get all the people in the address book */
        let allPeople = ABAddressBookCopyArrayOfAllPeople(
            addressBook).takeRetainedValue() as [ABRecord]
        
        for person: ABRecord in allPeople{
            
            let firstName = ABRecordCopyValue(person,
                kABPersonFirstNameProperty).takeRetainedValue() as! String
            
            let lastName = ABRecordCopyValue(person,
                kABPersonLastNameProperty).takeRetainedValue()as! String
            
            
            print("First name = \(firstName)")
            print("Last name = \(lastName)")
            self.readEmailsForPerson(person)
        }
        
    }
    
    func readEmailsForPerson(_ person: ABRecord){
        
        let emails: ABMultiValue = ABRecordCopyValue(person,
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

