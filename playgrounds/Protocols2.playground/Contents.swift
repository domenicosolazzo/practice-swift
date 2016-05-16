//: Playground - noun: a place where people can play

import UIKit

protocol Vehicle{
    var wheels: Int? {get}
}

//var vehicle = Vehicle()
//print(vehicle.wheels)


class Car: Vehicle {
    var wheels: Int? = 4
}
var car = Car()
print("Is Car? \(car is Car)")
print("Is Vehicle? \(car is Vehicle)")
if let theWheels = car.wheels{
    print("\(car.wheels) - \(car.wheels!)")
}


class Motocicletta:Vehicle{
    var wheels: Int? = 2
}

var motocicletta = Motocicletta()
print("Is Motocicletta? \(motocicletta is Motocicletta)")
print("Is Vehicle? \(motocicletta is Vehicle)")

var veicolo: Vehicle = Motocicletta()
print("Is Car? \(veicolo is Car)")
print("Is Vehicle? \(veicolo is Vehicle)")
print("Is Motocicletta? \(veicolo is Motocicletta)")
print("Number of wheels: \(veicolo.wheels!)")

var returnedVehicle = veicolo as? Motocicletta
print(returnedVehicle)
