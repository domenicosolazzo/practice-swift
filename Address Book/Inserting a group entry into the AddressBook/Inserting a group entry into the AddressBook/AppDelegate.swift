//
//  AppDelegate.swift
//  Inserting a group entry into the AddressBook
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
            self.newGroupWithName("My Group", inAddressBook: addressBook!)
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
            self.newGroupWithName("My Group", inAddressBook: addressBook!)
            
        }
    }
    
    func newGroupWithName(name: String, inAddressBook: ABAddressBookRef) ->
        ABRecordRef?{
            
            let group: ABRecordRef = ABGroupCreate().takeRetainedValue()
            
            var error: Unmanaged<CFError>?
            let couldSetGroupName = ABRecordSetValue(group,
                kABGroupNameProperty, name, &error)
            
            if couldSetGroupName{
                
                error = nil
                let couldAddRecord = ABAddressBookAddRecord(inAddressBook,
                    group,
                    &error)
                
                if couldAddRecord{
                    
                    println("Successfully added the new group")
                    
                    if ABAddressBookHasUnsavedChanges(inAddressBook){
                        error = nil
                        let couldSaveAddressBook =
                        ABAddressBookSave(inAddressBook, &error)
                        if couldSaveAddressBook{
                            println("Successfully saved the address book")
                        } else {
                            println("Failed to save the address book")
                            return nil
                        }
                    } else {
                        println("No unsaved changes")
                        return nil
                    }
                } else {
                    println("Could not add a new group")
                    return nil
                }
            } else {
                println("Failed to set the name of the group")
                return nil
            }
            
            return group
            
    }
    
    func createNewGroupInAddressBook(addressBook: ABAddressBookRef){
        
        let personalCoachesGroup: ABRecordRef? =
        newGroupWithName("Personal Coaches",
            inAddressBook: addressBook)
        
        if let group: ABRecordRef = personalCoachesGroup{
            println("Successfully created the group")
        } else {
            println("Could not create the group")
        }
        
    }
    
    


}

