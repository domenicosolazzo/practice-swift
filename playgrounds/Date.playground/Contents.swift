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
var components = NSCalendar.currentCalendar().componentsInTimeZone(
    NSTimeZone.localTimeZone(), fromDate: now)

dump(components)

// Create date from components
components = NSDateComponents()
components.year = 2015
components.month = 8
components.day = 25
components.hour = 10
components.minute = 20
components.second = 30
var birthday = NSCalendar.currentCalendar().dateFromComponents(components)
println(date)




