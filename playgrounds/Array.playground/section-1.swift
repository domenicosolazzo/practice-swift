// Array: An array stores multiple values of the same type
import Cocoa

/*
====== Array literal ======
*/
var arr: String[] = ["Domenico", "Italian"]

/*
====== Counting ======
*/
var count = arr.count

/*
====== Checking if an array is empty ======
*/
var isEmpty = arr.isEmpty

/*
====== Append an item at the end ======
*/
arr.append("last")
// ...Or use the addition assignment operator
arr += "next"
arr += ["next2", "abc"]

/*
====== Retrieve a value ======
*/
var firstValue = arr[0]

/*
====== Override a value ======
*/
arr[0] = "Updated"

/*
====== Insert a value at a specific index ======
*/
arr.insert("new-element", atIndex: 0)

/*
====== Remove an item at a certain index ======
*/
arr.removeAtIndex(0)

/*
====== Remove the last element of the array ======
*/
arr.removeLast()

/*
====== Remove all the elements ======
*/
arr.removeAll(keepCapacity: false)

/*
====== Iterate over an array ======
*/
for val in arr{
    var temp = val
}

for (index, val) in enumerate(arr){
    var i = index
    var temp = val
}

/*
====== Initializing an array ======
*/
var someInts = Int()[]
// ..Or
someInts = []

/*
====== Reverse an array ======
*/
var ordered = [1,2,3,4,5]
var reversed = ordered.reverse()

println(reversed)












