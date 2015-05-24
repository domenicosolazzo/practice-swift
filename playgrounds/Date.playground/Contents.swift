//: Playground - noun: a place where people can play

import UIKit

// Gregorian era enumeration
enum GregorianEra: Int{
    case BC = 0
    case AD
}

// Create a date in BC era
var date = NSCalendar.currentCalendar().dateWithEra(GregorianEra.BC.rawValue, year: 2015, month: 08, day: 25, hour: 20, minute: 22, second: 1, nanosecond: 22)

if date != nil{
    println("The date is \(date)")
}else{
    println("Error")
}


// Create a date in AD era
date = NSCalendar.currentCalendar().dateWithEra(GregorianEra.AD.rawValue, year: 2015, month: 08, day: 25, hour: 20, minute: 22, second: 1, nanosecond: 22)

if date != nil{
    println("The date is \(date)")
}else{
    println("Error")
}

// Adding 10 minutes to the current date
var now = NSDate()

let tenMinutesAfter = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitMinute, value: 10, toDate: now, options: NSCalendarOptions.MatchNextTime)
println("Now: \(now) and ten minutes after: \(tenMinutesAfter)")


// Retrieving date components
now = NSDate()
let components = NSCalendar.currentCalendar().componentsInTimeZone(
    NSTimeZone.localTimeZone(), fromDate: now)

dump(components)





