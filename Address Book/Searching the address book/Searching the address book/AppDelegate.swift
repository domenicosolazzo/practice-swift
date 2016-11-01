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
    lazy var addressBook: ABAddressBook = {
        var error: Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue() as ABAddressBook
        }()

    func doesPersonExistWithFirstName(firstName paramFirstName: String,
        lastName paramLastName: String,
        inAddressBook addressBook: ABAddressBook) -> Bool{
            
            _ = false
            let people = ABAddressBookCopyArrayOfAllPeople(
                addressBook).takeRetainedValue() as NSArray as [ABRecord]
            
            for person: ABRecord in people{
                
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
    
    func doesGroupExistWithGroupName(_ name: String,
        inAddressBook addressBook: ABAddressBook) -> Bool{
            
            let groups = ABAddressBookCopyArrayOfAllGroups(
                addressBook).takeRetainedValue() as NSArray as [ABRecord]
            
            for group: ABRecord in groups{
                
                let groupName = ABRecordCopyValue(group,
                    kABGroupNameProperty).takeRetainedValue() as! String
                
                if groupName == name{
                    return true
                }
                
            }
            return false
    }
    
    func doesPersonExistWithFullName(_ fullName: String,
        inAddressBook addressBook: ABAddressBook) -> Bool{
            
            let people = ABAddressBookCopyPeopleWithName(addressBook,
                fullName as NSString as CFString).takeRetainedValue() as NSArray
            
            if people.count > 0{
                return true
            }
            
            return false
            
    }
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            
            switch ABAddressBookGetAuthorizationStatus(){
            case .authorized:
                print("Already authorized")
                if doesPersonExistWithFullName("Richard Branson",
                    inAddressBook: addressBook){
                        print("This person exists")
                } else {
                    print("This person doesn't exist")
                }
            case .denied:
                print("You are denied access to address book")
                
            case .notDetermined:
                ABAddressBookRequestAccessWithCompletion(addressBook,
                    {[weak self] (granted: Bool, error: CFError?) in
                        
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
            case .restricted:
                print("Access is restricted")
                
            default:
                print("Unhandled")
            }
            
            return true
    }
    
}

