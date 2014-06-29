// Playground: Generics
/*
/*
==== Subclassing ====
*/
Generic code enables you to write flexible, reusable functions and types
that can work with any type, subject to requirements that you define. Yo
can write code that avoids duplication and expresses its intent in a clear,
abstracted manner.
*/
import Cocoa

// This function can work with any type
func swapTwoValues<T>(inout a:T, inout b:T){
    let temporaryA = a
    a = b
    b = temporaryA
}
var firstInt = 3
var secondInt = 103

// Int example
swapTwoValues(&firstInt, &secondInt)
println("\(firstInt)" + " - \(secondInt)" )

// String example
var firstString = "First"
var secondString = "Second"
swapTwoValues(&firstString, &secondString)
println(firstString + " - " + secondString)


// Not-generic version of a Stack
struct InStack{
    var items = Int[]()
    
    mutating func push(i:Int){
        items.append(i)
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

// Generic version of Stack
struct GenericInStack<T>{
    var items = T[]()
    
    mutating func push(i:T){
        items.append(i)
    }
    
    mutating func pop() -> T{
        return items.removeLast()
    }

}

// Example for the GenericInStack
var stackOfStrings = GenericInStack<String>()
stackOfStrings.push("First")
stackOfStrings.push("Second")
stackOfStrings.push("Third")
var pullElement = stackOfStrings.pop()
println(pullElement)


/*
====== Type constraints ======
*/
/**
It is sometimes useful to enforce certain type constraints on
the types that can be used with generic functions and generic
types. Type constraints specify that a type parameter must
inherit from a specific class, or conform to a particular
protocol or protocol composition
*/

/* Not-generic example
Here’s a non-generic function called findStringIndex, which is
given a String value to find and an array of String values
within which to find it. The findStringIndex function returns
an optional Int value, which will be the index of the first
matching string in the array if it is found, or nil if the
string cannot be found
*/
func findStringIndex(array:String[], valueToFind: String)->Int?{
    for (index, value) in enumerate(array){
        if(value == valueToFind){
            return index
        }
    }
    return nil
}
let strings = ["cats", "dogs", "tigers"]
var index = findStringIndex(strings, "dogs")
println("The index is \(index)")

/* Generic example
You must use Equatable protocol if you want to compare values
using == and !=
*/
func findIndex<T: Equatable>(array: T[], valueToFind: T)->Int?{
    for (index, value) in enumerate(array){
        if value == valueToFind{
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex([1.23, 22.11, 424.11, 3.2], 3.2)
let stringIndex = findIndex(["Domenico", "Sandro", "Guido"], "Domenico")
