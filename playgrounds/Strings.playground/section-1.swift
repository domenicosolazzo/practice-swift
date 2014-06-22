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




