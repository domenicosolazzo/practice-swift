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
        count += 1;
        print("Count is \(count)")
        if (number == key) {
            let results = "value \(key) found.."
            break
        }
    }
}

linearSearch(key: 8);
count = 0;

// Logarithmic Search - O(log n)
// Binary approach
func binarySearch(key: Int, imin: Int, imax: Int) {
    count += 1
    print("Count is \(count)")
    
    //find the value at the middle index
    
    let midIndex : Double = round(Double((imin + imax) / 2))
    let midNumber = numberList[Int(midIndex)]
    
    //use recursion to reduce the possible search range
    if (midNumber > key ) {
        binarySearch(key: key, imin: imin, imax: Int(midIndex) - 1)
    }
        
    else if (midNumber < key ) {
        binarySearch(key: key, imin: Int(midIndex) + 1, imax: imax)
    }
        
    else {
        let results = "value \(key) found.."
    }
    
}

binarySearch(key: 8, imin: 0, imax: numberList.count)




