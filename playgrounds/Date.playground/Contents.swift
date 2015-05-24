//: Playground - noun: a place where people can play

import UIKit

// Gregorian era enumeration
enum GregorianEra: Int{
    case BC = 0
    case AD
}

// Create a date in BC era
let date = NSCalendar.currentCalendar().dateWithEra(GregorianEra.BC.rawValue, year: 2015, month: 08, day: 25, hour: 20, minute: 22, second: 1, nanosecond: 22)

if date != nil{
    println("The date is \(date)")
}else{
    println("Error")
}



