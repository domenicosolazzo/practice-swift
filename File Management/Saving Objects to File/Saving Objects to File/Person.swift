//
//  Person.swift
//  Saving Objects to File
//
//  Created by Domenico on 27/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import Cocoa

@objc(Person) class Person: NSObject, NSCoding{
    var firstName: String
    var lastName: String
    
    struct SerializationKey{
        static let firstName = "firstName"
        static let lastName = "lastName"
    }
    
    init(firstName: String, lastName: String){
        self.firstName = firstName
        self.lastName = lastName
        super.init()
    }
    
    convenience override init(){
        self.init(firstName: "Vandad", lastName: "Nahavandipoor")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObjectForKey(SerializationKey.firstName)
            as! String
        
        self.lastName = aDecoder.decodeObjectForKey(SerializationKey.lastName)
            as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstName, forKey: SerializationKey.firstName)
        aCoder.encodeObject(self.lastName, forKey: SerializationKey.lastName)
    }
    
}

func == (lhs: Person, rhs: Person) -> Bool{
    return lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName ? true : false
}
