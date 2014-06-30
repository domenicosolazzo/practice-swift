// Playground: Classes

import Cocoa

/**
==== Syntax ====
*/
class SomeClass{
    var age: String
    
    init(){
        self.age = "1"
    }
}

// Class instance
var someClass = SomeClass()


// Call a property
someClass.age = "32"
var age = someClass.age

// Membership initializers
class AnotherClass{
    var age: String
    
    init(Age:String){
        self.age = Age
    }

}

var anotherClass = AnotherClass(Age:"32")
age = anotherClass.age

