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
            print("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            self.createNewGroupInAddressBook(addressBook!)
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
            self.createNewGroupInAddressBook(addressBook!)
            
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
                    
                    print("Successfully added the new group")
                    
                    if ABAddressBookHasUnsavedChanges(inAddressBook){
                        error = nil
                        let couldSaveAddressBook =
                        ABAddressBookSave(inAddressBook, &error)
                        if couldSaveAddressBook{
                            print("Successfully saved the address book")
                        } else {
                            print("Failed to save the address book")
                            return nil
                        }
                    } else {
                        print("No unsaved changes")
                        return nil
                    }
                } else {
                    print("Could not add a new group")
                    return nil
                }
            } else {
                print("Failed to set the name of the group")
                return nil
            }
            
            return group
            
    }
    
    func createNewGroupInAddressBook(addressBook: ABAddressBookRef){
        
        let personalCoachesGroup: ABRecordRef? =
        newGroupWithName("Personal Coaches",
            inAddressBook: addressBook)
        
        if let _: ABRecordRef = personalCoachesGroup{
            print("Successfully created the group")
        } else {
            print("Could not create the group")
        }
        
    }
    
    


}

