// Subscript
/*
Classes, structures, and enumerations can define subscripts, which are
shortcuts for accessing the member elements of a collection, list, or
sequence. You use subscripts to set and retrieve values by index without
needing separate methods for setting and retrieval. 

For example, you access
elements in an Array instance as someArray[index] and elements in a
Dictionary instance as someDictionary[key].

*/
import Cocoa

struct TimesTable{
    let multiplier: Int
    
    subscript(index:Int) -> Int{
        return multiplier * index
    }
}

var timesTableInstance = TimesTable(multiplier: 3)
var subscriptResult = timesTableInstance[6] // Expecting 18
println(subscriptResult)

