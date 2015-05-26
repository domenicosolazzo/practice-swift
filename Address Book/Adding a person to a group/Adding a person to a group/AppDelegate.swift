//
//  AppDelegate.swift
//  Adding a person to a group
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
            
            
        }
    }
    
    //- MARK: Groups
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
    
    //- MARK: Person
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
    
    func addPerson(person: ABRecordRef,
        toGroup: ABRecordRef,
        saveToAddressBook: ABAddressBookRef) -> Bool{
            
            var error: Unmanaged<CFErrorRef>? = nil
            var added = false
            
            /* Now attempt to add the person entry to the group */
            added = ABGroupAddMember(toGroup,
                person,
                &error)
            
            if added == false{
                println("Could not add the person to the group")
                return false
            }
            
            /* Make sure we save any unsaved changes */
            if ABAddressBookHasUnsavedChanges(saveToAddressBook){
                error = nil
                let couldSaveAddressBook = ABAddressBookSave(saveToAddressBook,
                    &error)
                if couldSaveAddressBook{
                    println("Successfully added the person to the group")
                    added = true
                } else {
                    println("Failed to save the address book")
                }
            } else {
                println("No changes were saved")
            }
            
            return added
            
    }
    
    func addPersonsAndGroupsToAddressBook(addressBook: ABAddressBookRef){
        
        let richardBranson: ABRecordRef? = newPersonWithFirstName("Richard",
            lastName: "Branson",
            inAddressBook: addressBook)
        
        if let richard: ABRecordRef = richardBranson{
            let entrepreneursGroup: ABRecordRef? = newGroupWithName("Entrepreneurs",
                inAddressBook: addressBook)
            
            if let group: ABRecordRef = entrepreneursGroup{
                if addPerson(richard, toGroup: group, saveToAddressBook: addressBook){
                    println("Successfully added Richard Branson to the group")
                } else {
                    println("Failed to add Richard Branson to the group")
                }
                
            } else {
                println("Failed to create the group")
            }
            
        } else {
            println("Failed to create an entity for Richard Branson")
        }
        
    }



    
}

