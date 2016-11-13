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
func swapTwoValues<T>( a:inout T, b:inout T){
    let temporaryA = a
    a = b
    b = temporaryA
}
var firstInt = 3
var secondInt = 103

// Int example
swapTwoValues(a: &firstInt, b: &secondInt)
print("\(firstInt)" + " - \(secondInt)" )

// String example
var firstString = "First"
var secondString = "Second"
swapTwoValues(a: &firstString, b: &secondString)
print(firstString + " - " + secondString)


// Not-generic version of a Stack
struct InStack{
    var items = [Int]()
    
    mutating func push(i:Int){
        items.append(i)
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
}

// Generic version of Stack


// Example for the GenericInStack
var stackOfStrings = Stack<String>()
stackOfStrings.push("First")
stackOfStrings.push("Second")
stackOfStrings.push("Third")
var pullElement = stackOfStrings.pop()
print(pullElement)


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
func findStringIndex(array:[String], valueToFind: String)->Int?{
    for (index, value) in array.enumerated(){
        if(value == valueToFind){
            return index
        }
    }
    return nil
}
let strings = ["cats", "dogs", "tigers"]
var index = findStringIndex(array: strings, valueToFind: "dogs")
print("The index is \(index)")

/* Generic example
You must use Equatable protocol if you want to compare values
using == and !=
*/
func findIndex<T: Equatable>(array: [T], valueToFind: T)->Int?{
    for (index, value) in array.enumerated(){
        if value == valueToFind{
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex(array: [1.23, 22.11, 424.11, 3.2], valueToFind: 3.2)
let stringIndex = findIndex(array: ["Domenico", "Sandro", "Guido"], valueToFind: "Domenico")


/* 
====== Associated Types ======
When defining a protocol, it is sometimes useful to declare one
or more associated types as part of the protocol’s definition.
An associated type gives a placeholder name (or alias) to a
type that is used as part of the protocol. The actual type to
use for that associated type is not specified until the
protocol is adopted. Associated types are specified with the
typealias keyword.
*/
protocol Container{

    associatedtype ItemType
    mutating func append(item:ItemType)
    var count:Int {get}
    subscript(i:Int) -> ItemType{get}
}
// Switft can infer the appropriate ItemType to use
struct Stack<T>:Container{
    var items = [T]()
    mutating func push(item:T){
        items.append(item)
    }
    mutating func pop() -> T{
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    mutating func append(item:T){
        self.push(item: item)
    }
    var count:Int{
        return items.count
    }
    subscript(i:Int) -> T{
        return items[i]
    }
}

/*
====== Where clauses =======
It can also be useful to define requirements for associated
types. You do this by defining where clauses as part of a
type parameter list. A where clause enables you to require
that an associated type conforms to a certain protocol, and
or that certain type parameters and associated types be the
same. You write a where clause by placing the where keyword
immediately after the list of type parameters, followed by
one or more constraints for associated types, and/or one or
more equality relationships between types and associated
types.
*/
func allItemsMatch<C1: Container, C2: Container>
    (someContainer:C1, anotherContainer:C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable{
         
            // Check that both containers contain the same number of items
            if someContainer.count != anotherContainer.count{
                return false
            }
            
            // Check each pair of items to see if they are equivalent
            for i in (0 ..< someContainer.count){
                if someContainer[i] != anotherContainer[i]{
                    return false
                }
            }
            return true
}


