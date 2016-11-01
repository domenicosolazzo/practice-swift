//
//  Person.swift
//  Saving Objects to File
//
//  Created by Domenico on 27/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding{
    public func encode(with aCoder: NSCoder) {
        
    }

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
        self.firstName = aDecoder.decodeObject(forKey: SerializationKey.firstName)
            as! String
        
        self.lastName = aDecoder.decodeObject(forKey: SerializationKey.lastName)
            as! String
    }
    
    func encodewithWithCoder(_ aCoder: NSCoder) {
        aCoder.encode(self.firstName, forKey: SerializationKey.firstName)
        aCoder.encode(self.lastName, forKey: SerializationKey.lastName)
    }
    
}

func == (lhs: Person, rhs: Person) -> Bool{
    return lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName ? true : false
}
