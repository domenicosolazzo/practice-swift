/** 
    Big O Notation
    Source: http://waynewbishop.com/swift/big-o-notation
*/

//a simple array of sorted integers
let numberList : Array<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Linear Search O(N)
// Brute force approach
func linearSearch(key: Int) {
    
    //check all possible values until we find a match
    for number in numberList {
        if (number == key) {
            let results = "value \(key) found.."
            break
        }
    }
}

linearSearch(10);



