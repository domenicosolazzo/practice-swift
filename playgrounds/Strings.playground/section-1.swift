// Playground - noun: a place where people can play

import Cocoa

/*
======== A string ========
*/
var str = "Hello, playground"

/*
======== Immutable string ========
*/
let immutableString = "This is immutable"

/*
======== Create a character constant ========
*/
let euroSymbolConstant: Character = "€"

/* 
======== Create a character value ========
*/
var euroSymbol: Character = "€"


/* 
======== Initializing an empty string ========
*/
var emptyString = String()
// Or..
emptyString = ""

/*
======== Concatenating strings ========
*/
var str1 = "Hello"
var str2 = "World"
var finalResult = (str1 + str2)

/* 
======== String interpolation ========
*/
let name: String  = "Domenico"
var interpolation = "My name is \(name)"

/*
======== Counting characters ========
*/
var count = (countElements("Domenico"))

/*
======== String equality ========
*/
var equality1 = "Domenico"
var equality2 = "Domenico"

if(equality1 == equality2){
    var equal = "These two strings are equal"
}


/*
======== Uppercase & Lowercase ========
*/
var myString = "This is a string"
var uppercase = myString.uppercaseString
var lowercase = myString.lowercaseString

/*
======== Substrings ========
*/
// Check if a substring exists in a string
var containString = myString.rangeOfString("This", options: nil, range:nil, locale: nil)
// Retrieve a substring
var substring = myString.substringFromIndex(4)
// Retrieve first part of the substring
substring = myString.substringToIndex(4)

/*
======== Trimming ========
*/
myString = "   This should be trimmed   "
// Trimming of whitespaces
myString = myString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
// Trimming of both newline and whitespaces
myString = myString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())


/*
======== Splitting strings ========
*/
var cities = "Rome, Milan, Paris, New York"
var splittedCities: String[] = cities.componentsSeparatedByString(",")
// Using more than one character
var stringToSplit = "A-B-C-D, ciao"
var newString = stringToSplit.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: "-,"))

/*
======== Converting a String to NSData ========
*/
let string1 = "String to encode"
let string2: NSString = myString
let data = string2.dataUsingEncoding(NSUTF8StringEncoding)

/*
======== Prefix & Suffix ========
*/
let romeoAndJuliet = "Act 1 Scene 1: Verona, A public place"
var hasPrefix = romeoAndJuliet.hasPrefix("Act 1")
var hasSuffix = romeoAndJuliet.hasSuffix("place")


/*
======== Unicode ========
*/
// Four-byte unicode scalar
let unicode1 = "\U0001F496"
// Two-byte unicode scalar
let unicode2 = "\u2665"
// One-byte unicode scalar
let unicode3 = "\x24"









