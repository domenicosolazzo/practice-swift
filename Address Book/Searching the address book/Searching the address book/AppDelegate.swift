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
            
            _ = false
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
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
            
            switch ABAddressBookGetAuthorizationStatus(){
            case .Authorized:
                print("Already authorized")
                if doesPersonExistWithFullName("Richard Branson",
                    inAddressBook: addressBook){
                        print("This person exists")
                } else {
                    print("This person doesn't exist")
                }
            case .Denied:
                print("You are denied access to address book")
                
            case .NotDetermined:
                ABAddressBookRequestAccessWithCompletion(addressBook,
                    {[weak self] (granted: Bool, error: CFError!) in
                        
                        if granted{
                            let strongSelf = self!
                            print("Access is granted")
                            if strongSelf.doesPersonExistWithFullName("Richard Branson",
                                inAddressBook: strongSelf.addressBook){
                                    print("This person exists")
                            } else {
                                print("This person doesn't exist")
                            }
                        } else {
                            print("Access is not granted")
                        }
                        
                    })
            case .Restricted:
                print("Access is restricted")
                
            default:
                print("Unhandled")
            }
            
            return true
    }
    
}

