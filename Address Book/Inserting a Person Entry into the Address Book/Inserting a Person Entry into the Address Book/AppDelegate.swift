//
//  AppDelegate.swift
//  Inserting a Person Entry into the Address Book
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
            println("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            self.newPersonWithFirstName("Domenico", lastName: "Solazzo", inAddressBook: addressBook!)
        case .Denied:
            println("You are denied access to address book")
            
        case .NotDetermined:
            createAddressBook()
            if let theBook: ABAddressBookRef = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                    {(granted: Bool, error: CFError!) in
                        
                        if granted{
                            println("Access is granted")
                        } else {
                            println("Access is not granted")
                        }
                        
                })
            }
            
        case .Restricted:
            println("Access is restricted")
            
        default:
            println("Unhandled")
        }

        
        return true
        
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
            self.newPersonWithFirstName("Domenico", lastName: "Solazzo", inAddressBook: addressBook!)
            
        }
    }
    
    func newPersonWithFirstName(firstName: String,
        lastName: String,
        inAddressBook: ABAddressBookRef) -> ABRecordRef?{
            
            let person: ABRecordRef = ABPersonCreate().takeRetainedValue()
            
            let couldSetFirstName = ABRecordSetValue(person,
                kABPersonFirstNameProperty,
                firstName as CFTypeRef,
                nil)
            
            let couldSetLastName = ABRecordSetValue(person,
                kABPersonLastNameProperty,
                lastName as CFTypeRef,
                nil)
            
            var error: Unmanaged<CFErrorRef>? = nil
            
            let couldAddPerson = ABAddressBookAddRecord(inAddressBook, person, &error)
            
            if couldAddPerson{
                println("Successfully added the person.")
            } else {
                println("Failed to add the person.")
                return nil
            }
            
            if ABAddressBookHasUnsavedChanges(inAddressBook){
                
                var error: Unmanaged<CFErrorRef>? = nil
                let couldSaveAddressBook = ABAddressBookSave(inAddressBook, &error)
                
                if couldSaveAddressBook{
                    println("Successfully saved the address book.")
                } else {
                    println("Failed to save the address book.")
                }
            }
            
            if couldSetFirstName && couldSetLastName{
                println("Successfully set the first name " +
                    "and the last name of the person")
            } else {
                println("Failed to set the first name and/or " +
                    "the last name of the person")
            }
            
            return person
            
    }
}

