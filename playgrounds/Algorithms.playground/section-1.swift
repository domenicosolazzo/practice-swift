// Playground: Algorithms
import Cocoa

/**
==== Bubble Sort ====
*/
var inputArray = Int[]()

func swapNumbers(i1: Int, i2: Int){
    let temp = inputArray[i1]
    inputArray[i1] = inputArray[i2]
    inputArray[i2] = temp
}

func bubbleSort(inputArray: Int[]){
    for var index: Int = inputArray.count-1; index > 1; --index{
        for var j:Int = 0; j < index; ++j{
            if inputArray[j] > inputArray[j + 1]{
                println("Swapping \(inputArray[j]) with \(inputArray[j+1])")
                swapNumbers(j, j + 1)
            }
        }
    }
}

// Generate random numbers 
for r in 0..10{
    inputArray.append(((Int(arc4random()))%100))
}

// call bubblesort
println("Before Bubble sort")
inputArray
bubbleSort(inputArray)
println("After Bubble sort")
inputArray