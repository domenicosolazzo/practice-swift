// Playground: Inheritance
/*
A class can inherit methods, properties, and other characteristics from
another class. When one class inherits from another, the inheriting class
is known as a subclass, and the class it inherits from is known as its
superclass. Inheritance is a fundamental behavior that differentiates
classes from other types in Swift.
*/
import Cocoa

class Vehicle{
    var numberOfWheels: Int
    var maxPassengers: Int
    
    func description() -> String{
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
    
    init(){
        numberOfWheels = 0
        maxPassengers = 1
    }
}


let someVehicle = Vehicle()

/*
==== Subclassing ====
*/
class Bicycle:Vehicle{

    init(){
        super.init()
        numberOfWheels = 2
    }
}

let someBicycle = Bicycle()
println(someBicycle.description())


class Tandem:Bicycle{
    init(){
        super.init()
        maxPassengers = 2
    }
}
let someTandem = Tandem()
println(someTandem.description())