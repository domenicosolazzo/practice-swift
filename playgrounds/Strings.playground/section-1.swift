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










