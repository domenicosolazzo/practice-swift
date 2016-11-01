//
//  AppDelegate.swift
//  Writing to and Reading from Files
//
//  Created by Domenico on 27/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func saveAndReadString(){
        let someText = NSString(string: "Put some string here")
        let destinationPath = NSTemporaryDirectory() + "MyFile.txt"
        
        do{
        _ = try someText.write(toFile: destinationPath,
            atomically: true,
            encoding: String.Encoding.utf8.rawValue)
            print("Successfully stored the file at path \(destinationPath)")
        }catch{
             print("An error occurred")
        }
        
    }
    
    func saveAndReadArray(){
        
        let path = NSTemporaryDirectory() + "MyFile.txt"
        let arrayOfNames:NSArray = ["Steve", "John", "Edward"]
        
        if arrayOfNames.write(toFile: path, atomically: true){
            let readArray:NSArray? = NSArray(contentsOfFile: path)
            if let array = readArray{
                print("Could read the array back = \(array)")
            } else {
                print("Failed to read the array back")
            }
        }
        
    }
    
    func saveAndReadDictionary(){
        
        let path = NSTemporaryDirectory() + "MyFile.txt"
        let dict:NSDictionary = [
            "first name" : "Steven",
            "middle name" : "Paul",
            "last name" : "Jobs",
        ]
        
        if dict.write(toFile: path, atomically: true){
            
            let readDict:NSDictionary? = NSDictionary(contentsOfFile: path)
            if let dict = readDict{
                print("Read the dictionary back from disk = \(dict)")
            } else {
                print("Failed to read the dictionary back from disk")
            }
        } else {
            print("Failed to write the dictionary to disk")
        }
        
    }
    
    func saveAndReadData(){
        let path = NSTemporaryDirectory() + "MyFile.txt"
        let chars = [CUnsignedChar(ascii: "a"), CUnsignedChar(ascii: "b")]
        let data = Data(bytes: UnsafePointer<UInt8>(chars), count: 2)
        if (try? data.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil{
            print("Wrote the data")
            let readData = try? Data(contentsOf: URL(fileURLWithPath: path))
            if readData! == data{
                print("Read the same data")
            } else {
                print("Not the same data")
            }
        } else {
            print("Could not write the data")
        }
    }

}

