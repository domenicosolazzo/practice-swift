// Playground: Protocols
/**
A protocol defines a blueprint of methods, properties, and other
requirements that suit a particular task or piece of functionality. The
protocol doesn’t actually provide an implementation for any of these
requirements—it only describes what an implementation will look like. The
protocol can then be adopted by a class, structure, or enumeration to
provide an actual implementation of those requirements. Any type that
satisfies the requirements of a protocol is said to conform to that
protocol.

syntax
protocol SomeProtocol{
    // protocol definition here
}
*/
import Cocoa

/*
=== Property Requirements ===
*/
protocol SomeProtocol{
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int{get}
}

protocol FullyNamed{
    var fullName: String {get}
}

struct Person: FullyNamed{
    var fullName: String
}
let john = Person(fullName: "Domenico")
println(john.fullName)

/*
=== Method Requirements ===
*/
protocol RandomNumberGenerator{
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator{
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double{
        lastRandom = ( (lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
println("Here's a random number: \(generator.random())")
println("Here's a random number: \(generator.random())")

// Mutable func
protocol Togglable{
    mutating func toggle()
}

enum OnOffSwitch: Togglable{
    case Off, On
    mutating func toggle(){
        switch self{
            case Off:
              self = On
            case On:
              self = Off
        }
    }
}
var ligthSwitch = OnOffSwitch.Off
ligthSwitch.toggle()

/*
=== Protocols as Types ===
*/
class Dice{
    let sides:Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator){
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int{
        return Int(self.generator.random() * Double(self.sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator:LinearCongruentialGenerator())
for _ in 1...5{
    println("Random dice roll is \(d6.roll())")
}