/** 
    Big O Notation
    Source: http://waynewbishop.com/swift/big-o-notation
*/
import Foundation

//a simple array of sorted integers
let numberList : Array<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var count = 0;
// Linear Search O(N)
// Brute force approach
func linearSearch(key: Int) {
    //check all possible values until we find a match
    for number in numberList {
        count++;
        println("Count is \(count)")
        if (number == key) {
            let results = "value \(key) found.."
            break
        }
    }
}

linearSearch(8);
count = 0;

// Logarithmic Search - O(log n)
// Binary approach
func binarySearch(key: Int, imin: Int, imax: Int) {
    count++
    println("Count is \(count)")
    
    //find the value at the middle index
    
    var midIndex : Double = round(Double((imin + imax) / 2))
    var midNumber = numberList[Int(midIndex)]
    
    //use recursion to reduce the possible search range
    if (midNumber > key ) {
        binarySearch(key, imin, Int(midIndex) - 1)
    }
        
    else if (midNumber < key ) {
        binarySearch(key, Int(midIndex) + 1, imax)
    }
        
    else {
        let results = "value \(key) found.."
    }
    
}

binarySearch(8, 0, numberList.count)




