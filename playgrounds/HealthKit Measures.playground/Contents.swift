import UIKit
import HealthKit

/**
** Convert grams to Kilograms
**/
let gramUnit = HKUnit(fromMassFormatterUnit: NSMassFormatterUnit.Gram)
let kilogramUnit = HKUnit(fromMassFormatterUnit: NSMassFormatterUnit.Kilogram)

let weightInGrams:Double = 74_250

// Create a quantity object
let weightQuantity = HKQuantity(unit: gramUnit, doubleValue: weightInGrams)

// Convert the quantity to Kilograms
let weightInKilograms = weightQuantity.doubleValueForUnit(kilogramUnit)

println("Your wieght is \(weightInKilograms) kilograms")
println("Your weight is \(weightInGrams) grams")

/** 
**  Convert an exercise from 1500 calories to kilojaules
**/
let caloriesValue:Double = 1_500

// Calories unit
let caloriesUnit = HKQuantity(unit: HKUnit.calorieUnit(), doubleValue: caloriesValue)

let kilojoulesValue = caloriesUnit.doubleValueForUnit(HKUnit.jouleUnitWithMetricPrefix(HKMetricPrefix.Kilo))

// Energy formatter
let energyFormatter = NSEnergyFormatter()

let caloriesString = energyFormatter.stringFromValue(caloriesValue, unit: NSEnergyFormatterUnit.Calorie)
let kilojoulesString = energyFormatter.stringFromValue(kilojoulesValue, unit: NSEnergyFormatterUnit.Kilojoule)

println("You've burned \(caloriesString)")
println("You've burned \(kilojoulesString)")


/**
** Converting meters to feet
**/
let distanceInMeters:Double = 1_234

let metersUnit = HKQuantity(unit: HKUnit.meterUnit(),
    doubleValue: distanceInMeters)

let feetValue = metersUnit.doubleValueForUnit(HKUnit.footUnit())

let lengthFormatter = NSLengthFormatter()

let metersString = lengthFormatter.stringFromValue(distanceInMeters, unit: NSLengthFormatterUnit.Meter)
let feetString = lengthFormatter.stringFromValue(feetValue, unit: NSLengthFormatterUnit.Foot)

println("You've driven \(metersString)")
println("You've driven \(feetString)")

println(NSUUID().UUIDString)

