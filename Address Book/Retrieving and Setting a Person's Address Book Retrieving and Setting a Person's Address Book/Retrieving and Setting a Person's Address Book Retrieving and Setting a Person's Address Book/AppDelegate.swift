//
//  AppDelegate.swift
//  Retrieving and Setting a Person's Address Book Retrieving and Setting a Person's Address Book
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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .authorized:
            print("Already authorized")
            performExample()
        case .denied:
            print("You are denied access to address book")
            
        case .notDetermined:
            ABAddressBookRequestAccessWithCompletion(addressBook,
                {[weak self] (granted: Bool, error: CFError?) in
                    
                    if granted{
                        let strongSelf = self!
                        print("Access is granted")
                        strongSelf.performExample()
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
    
    func imageForPerson(_ person: ABRecord) -> UIImage?{
        
        let data = ABPersonCopyImageData(person).takeRetainedValue() as Data
        
        let image = UIImage(data: data)
        return image
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
                print("Successfully added the person")
            } else {
                print("Failed to add the person.")
                return nil
            }
            
            if ABAddressBookHasUnsavedChanges(inAddressBook){
                
                var error: Unmanaged<CFError>? = nil
                let couldSaveAddressBook = ABAddressBookSave(inAddressBook, &error)
                
                if couldSaveAddressBook{
                    print("Successfully saved the address book")
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
    
    func setImageForPerson(_ person: ABRecord,
        inAddressBook addressBook: ABAddressBook,
        imageData: Data) -> Bool{
            
            var error: Unmanaged<CFError>? = nil
            
            let couldSetPersonImage =
            ABPersonSetImageData(person, imageData as CFData, &error)
            
            if couldSetPersonImage{
                print("Successfully set the person's image. Saving...")
                if ABAddressBookHasUnsavedChanges(addressBook){
                    error = nil
                    
                    let couldSaveAddressBook = ABAddressBookSave(addressBook, &error)
                    
                    if couldSaveAddressBook{
                        print("Successfully saved the address book")
                        return true
                    } else {
                        print("Failed to save the address book")
                    }
                } else {
                    print("There are no changes to be saved!")
                }
            } else {
                print("Failed to set the person's image")
            }
            
            return false
            
    }
    
    func performExample(){
        let person: ABRecord? = newPersonWithFirstName("Richard",
            lastName: "Branson", inAddressBook: addressBook)
        
        if let richard: ABRecord = person{
            
            let newImage = UIImage(named: "image")
            let newImageData = UIImageJPEGRepresentation(newImage!, 1.0)
            
            if setImageForPerson(richard, inAddressBook: addressBook,
                imageData: newImageData!){
                    
                    print("Successfully set the person's image")
                    
                    let image = imageForPerson(richard)
                    
                    if image != nil{
                        print("Found the image")
                    } else {
                        print("This person has no image")
                    }
                    
            } else {
                print("Could not set the person's image")
            }
            
        }
        
    }
    
}

