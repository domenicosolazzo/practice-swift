import UIKit
import HealthKit

/**
** Convert grams to Kilograms
**/
let gramUnit = HKUnit(from: MassFormatter.Unit.gram)
let kilogramUnit = HKUnit(from: MassFormatter.Unit.kilogram)

let weightInGrams:Double = 74_250

// Create a quantity object
let weightQuantity = HKQuantity(unit: gramUnit, doubleValue: weightInGrams)

// Convert the quantity to Kilograms
let weightInKilograms = weightQuantity.doubleValue(for: kilogramUnit)

print("Your wieght is \(weightInKilograms) kilograms")
print("Your weight is \(weightInGrams) grams")

/** 
**  Convert an exercise from 1500 calories to kilojaules
**/
let caloriesValue:Double = 1_500

// Calories unit
let caloriesUnit = HKQuantity(unit: HKUnit.calorie(), doubleValue: caloriesValue)

let kilojoulesValue = caloriesUnit.doubleValue(for: HKUnit.jouleUnit(with: HKMetricPrefix.kilo))

// Energy formatter
let energyFormatter = EnergyFormatter()

let caloriesString = energyFormatter.string(fromValue: caloriesValue, unit: EnergyFormatter.Unit.calorie)
let kilojoulesString = energyFormatter.string(fromValue: kilojoulesValue, unit: EnergyFormatter.Unit.kilojoule)

print("You've burned \(caloriesString)")
print("You've burned \(kilojoulesString)")


/**
** Converting meters to feet
**/
let distanceInMeters:Double = 1_234

let metersUnit = HKQuantity(unit: HKUnit.meter(),
    doubleValue: distanceInMeters)

let feetValue = metersUnit.doubleValue(for: HKUnit.foot())

let lengthFormatter = LengthFormatter()

let metersString = lengthFormatter.string(fromValue: distanceInMeters, unit: LengthFormatter.Unit.meter)
let feetString = lengthFormatter.string(fromValue: feetValue, unit: LengthFormatter.Unit.foot)

print("You've driven \(metersString)")
print("You've driven \(feetString)")

print
(NSUUID().uuidString)

