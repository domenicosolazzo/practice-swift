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
    var addressBook: ABAddressBook?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .authorized:
            print("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            addPersonsAndGroupsToAddressBook(addressBook!)

        case .denied:
            print("You are denied access to address book")
            
        case .notDetermined:
            createAddressBook()
            if let theBook: ABAddressBook = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                            {(granted:Bool,  error:CFError?) -> Void in
                        
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
            addPersonsAndGroupsToAddressBook(addressBook!)
            
        }
    }
    
    //- MARK: Groups
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
    
    //- MARK: Person
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
    
    func addPerson(_ person: ABRecord,
        toGroup: ABRecord,
        saveToAddressBook: ABAddressBook) -> Bool{
            
            var error: Unmanaged<CFError>? = nil
            var added = false
            
            /* Now attempt to add the person entry to the group */
            added = ABGroupAddMember(toGroup,
                person,
                &error)
            
            if added == false{
                print("Could not add the person to the group")
                return false
            }
            
            /* Make sure we save any unsaved changes */
            if ABAddressBookHasUnsavedChanges(saveToAddressBook){
                error = nil
                let couldSaveAddressBook = ABAddressBookSave(saveToAddressBook,
                    &error)
                if couldSaveAddressBook{
                    print("Successfully added the person to the group")
                    added = true
                } else {
                    print("Failed to save the address book")
                }
            } else {
                print("No changes were saved")
            }
            
            return added
            
    }
    
    func addPersonsAndGroupsToAddressBook(_ addressBook: ABAddressBook){
        
        let richardBranson: ABRecord? = newPersonWithFirstName("Richard",
            lastName: "Branson",
            inAddressBook: addressBook)
        
        if let richard: ABRecord = richardBranson{
            let entrepreneursGroup: ABRecord? = newGroupWithName("Entrepreneurs",
                inAddressBook: addressBook)
            
            if let group: ABRecord = entrepreneursGroup{
                if addPerson(richard, toGroup: group, saveToAddressBook: addressBook){
                    print("Successfully added Richard Branson to the group")
                } else {
                    print("Failed to add Richard Branson to the group")
                }
                
            } else {
                print("Failed to create the group")
            }
            
        } else {
            print("Failed to create an entity for Richard Branson")
        }
        
    }



    
}

