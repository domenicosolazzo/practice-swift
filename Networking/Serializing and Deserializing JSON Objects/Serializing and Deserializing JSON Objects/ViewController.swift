//
//  ViewController.swift
//  Serializing and Deserializing JSON Objects
//
//  Created by Domenico Solazzo on 16/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dictionary:[NSString : AnyObject] =
        [
            "First Name" : "Anthony",
            "Last Name" : "Robbins",
            "Age" : 51,
            "children" : [
                "Anthony's Son 1",
                "Anthony's Daughter 1",
                "Anthony's Son 2",
                "Anthony's Son 3",
                "Anthony's Daughter 2"
            ],
        ]
        // Serializing data to JSON
        var jsonData = self.serializeDataToJSON(dictionary)
        // Deserializing a JSON
        var data: AnyObject? = self.deserializeJSON(jsonData!)
        println("End")
    }
    
    func serializeDataToJSON(dictionary:[NSString : AnyObject]) -> NSData?{
        /* Convert the dictionary into a data structure */
        var error: NSError?
        let jsonData = NSJSONSerialization.dataWithJSONObject(dictionary,
            options: .PrettyPrinted,
            error: &error)
        
        if let data = jsonData{
            if data.length > 0 && error == nil{
                println("Successfully serialized the dictionary into data")
                
                /* Then convert the data into a string */
                let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("JSON String = \(jsonString)")
                
            }
            else if data.length == 0 && error == nil{
                println("No data was returned after serialization.")
            }
            else if error != nil{
                println("An error happened = \(error)")
            }
        }
        return jsonData
    }
    
    func deserializeJSON(data:NSData) -> AnyObject?{
        /* Now try to deserialize the JSON object into a dictionary */
        var error: NSError?
        
        let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
            options: .AllowFragments,
            error: &error)
        
        if  error == nil{
            
            println("Successfully deserialized...")
            
            if jsonObject is NSDictionary{
                let deserializedDictionary = jsonObject as! NSDictionary
                println("Deserialized JSON Dictionary = \(deserializedDictionary)")
            }
            else if jsonObject is NSArray{
                let deserializedArray = jsonObject as! NSArray
                println("Deserialized JSON Array = \(deserializedArray)")
            }
            else {
                /* Some other object was returned. We don't know how to
                deal with this situation because the deserializer only
                returns dictionaries or arrays */
            }
        }
        else if error != nil{
            println("An error happened while deserializing the JSON data.")
        }

        return jsonObject;
    }
}

