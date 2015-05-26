//
//  AppDelegate.swift
//  Searching the address book
//
//  Created by Domenico on 26/05/15.
//  License MIT
//

import UIKit
import AddressBook

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var addressBook: ABAddressBookRef = {
        var error: Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue() as ABAddressBookRef
        }()

    func doesPersonExistWithFirstName(firstName paramFirstName: String,
        lastName paramLastName: String,
        inAddressBook addressBook: ABAddressBookRef) -> Bool{
            
            var exists = false
            let people = ABAddressBookCopyArrayOfAllPeople(
                addressBook).takeRetainedValue() as NSArray as [ABRecordRef]
            
            for person: ABRecordRef in people{
                
                let firstName = ABRecordCopyValue(person,
                    kABPersonFirstNameProperty).takeRetainedValue() as! String
                
                let lastName = ABRecordCopyValue(person,
                    kABPersonLastNameProperty).takeRetainedValue() as! String
                
                if firstName == paramFirstName &&
                    lastName == paramLastName{
                        return true
                }
                
            }
            return false
    }
    
    func doesGroupExistWithGroupName(name: String,
        inAddressBook addressBook: ABAddressBookRef) -> Bool{
            
            let groups = ABAddressBookCopyArrayOfAllGroups(
                addressBook).takeRetainedValue() as NSArray as [ABRecordRef]
            
            for group: ABRecordRef in groups{
                
                let groupName = ABRecordCopyValue(group,
                    kABGroupNameProperty).takeRetainedValue() as! String
                
                if groupName == name{
                    return true
                }
                
            }
            return false
    }
    
    func doesPersonExistWithFullName(fullName: String,
        inAddressBook addressBook: ABAddressBookRef) -> Bool{
            
            let people = ABAddressBookCopyPeopleWithName(addressBook,
                fullName as NSString as CFStringRef).takeRetainedValue() as NSArray
            
            if people.count > 0{
                return true
            }
            
            return false
            
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
}

