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
    var addressBook: ABAddressBook?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .authorized:
            print("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            self.newPersonWithFirstName("Domenico", lastName: "Solazzo", inAddressBook: addressBook!)
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
    
    func newPersonWithFirstName(_ firstName: String,
        lastName: String,
        inAddressBook: ABAddressBook) -> ABRecord?{
            
            let person: ABRecord = ABPersonCreate().takeRetainedValue()
            
            let couldSetFirstName = ABRecordSetValue(person,
                kABPersonFirstNameProperty,
                firstName as CFTypeRef,
                nil)
            
            let couldSetLastName = ABRecordSetValue(person,
                kABPersonLastNameProperty,
                lastName as CFTypeRef,
                nil)
            
            var error: Unmanaged<CFError>? = nil
            
            let couldAddPerson = ABAddressBookAddRecord(inAddressBook, person, &error)
            
            if couldAddPerson{
                print("Successfully added the person.")
            } else {
                print("Failed to add the person.")
                return nil
            }
            
            if ABAddressBookHasUnsavedChanges(inAddressBook){
                
                var error: Unmanaged<CFError>? = nil
                let couldSaveAddressBook = ABAddressBookSave(inAddressBook, &error)
                
                if couldSaveAddressBook{
                    print("Successfully saved the address book.")
                } else {
                    print("Failed to save the address book.")
                }
            }
            
            if couldSetFirstName && couldSetLastName{
                print("Successfully set the first name " +
                    "and the last name of the person")
            } else {
                print("Failed to set the first name and/or " +
                    "the last name of the person")
            }
            
            return person
            
    }
}

