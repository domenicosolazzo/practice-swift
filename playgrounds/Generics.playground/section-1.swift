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
stackOfStrings.pop("Third")
var pullElement = stackOfStrings.pull()
println(pullElement)
