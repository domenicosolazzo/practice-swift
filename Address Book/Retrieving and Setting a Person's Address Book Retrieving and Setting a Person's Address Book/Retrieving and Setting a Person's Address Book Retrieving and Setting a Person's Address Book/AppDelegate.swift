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
    lazy var addressBook: ABAddressBookRef = {
        var error: Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue() as ABAddressBookRef
        }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    func imageForPerson(person: ABRecordRef) -> UIImage?{
        
        let data = ABPersonCopyImageData(person).takeRetainedValue() as NSData
        
        let image = UIImage(data: data)
        return image
    }
    
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
                println("Successfully added the person")
            } else {
                println("Failed to add the person.")
                return nil
            }
            
            if ABAddressBookHasUnsavedChanges(inAddressBook){
                
                var error: Unmanaged<CFErrorRef>? = nil
                let couldSaveAddressBook = ABAddressBookSave(inAddressBook, &error)
                
                if couldSaveAddressBook{
                    println("Successfully saved the address book")
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
    
    func setImageForPerson(person: ABRecordRef,
        inAddressBook addressBook: ABAddressBookRef,
        imageData: NSData) -> Bool{
            
            var error: Unmanaged<CFErrorRef>? = nil
            
            let couldSetPersonImage =
            ABPersonSetImageData(person, imageData as CFDataRef, &error)
            
            if couldSetPersonImage{
                println("Successfully set the person's image. Saving...")
                if ABAddressBookHasUnsavedChanges(addressBook){
                    error = nil
                    
                    let couldSaveAddressBook = ABAddressBookSave(addressBook, &error)
                    
                    if couldSaveAddressBook{
                        println("Successfully saved the address book")
                        return true
                    } else {
                        println("Failed to save the address book")
                    }
                } else {
                    println("There are no changes to be saved!")
                }
            } else {
                println("Failed to set the person's image")
            }
            
            return false
            
    }
    
    func performExample(){
        let person: ABRecordRef? = newPersonWithFirstName("Richard",
            lastName: "Branson", inAddressBook: addressBook)
        
        if let richard: ABRecordRef = person{
            
            let newImage = UIImage(named: "image")
            let newImageData = UIImageJPEGRepresentation(newImage, 1.0)
            
            if setImageForPerson(richard, inAddressBook: addressBook,
                imageData: newImageData){
                    
                    println("Successfully set the person's image")
                    
                    let image = imageForPerson(richard)
                    
                    if let currentImage = image{
                        println("Found the image")
                    } else {
                        println("This person has no image")
                    }
                    
            } else {
                println("Could not set the person's image")
            }
            
        }
        
    }
    
}

