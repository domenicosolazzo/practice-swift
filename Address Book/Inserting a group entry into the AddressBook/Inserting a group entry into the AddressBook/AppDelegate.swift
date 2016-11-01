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
    var addressBook: ABAddressBook?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .authorized:
            print("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            self.createNewGroupInAddressBook(addressBook!)
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
            self.createNewGroupInAddressBook(addressBook!)
            
        }
    }
    
    func newGroupWithName(_ name: String, inAddressBook: ABAddressBook) ->
        ABRecord?{
            
            let group: ABRecord = ABGroupCreate().takeRetainedValue()
            
            var error: Unmanaged<CFError>?
            let couldSetGroupName = ABRecordSetValue(group,
                kABGroupNameProperty, name as CFTypeRef!, &error)
            
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
    
    func createNewGroupInAddressBook(_ addressBook: ABAddressBook){
        
        let personalCoachesGroup: ABRecord? =
        newGroupWithName("Personal Coaches",
            inAddressBook: addressBook)
        
        if let _: ABRecord = personalCoachesGroup{
            print("Successfully created the group")
        } else {
            print("Could not create the group")
        }
        
    }
    
    


}

