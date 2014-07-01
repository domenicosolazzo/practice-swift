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
func generateRandomValues(){
   for r in 0..10{
      inputArray.append(((Int(arc4random()))%100))
   }
}
generateRandomValues()
// call bubblesort
println("Before Bubble sort")
inputArray
bubbleSort(inputArray)
println("After Bubble sort")
inputArray

println("")
/**
==== Selection sort ====
*/
inputArray = Int[]()

var min: Int = 0

func selectionSort(inputArray: Int[]){
    println(inputArray)
    for var index:Int = 0; index < inputArray.count-1; ++index{
        min = index
        for(var j:Int = index+1; j < inputArray.count-1; ++j){
            if inputArray[j] < inputArray[min]{
                println("Found new min: \(inputArray[j]). Old min: \(inputArray[min])")
                println(inputArray)
                min = j
            }
        }
        swapNumbers(index, min)
    }
}

generateRandomValues()
println("Before Selection Sort")
inputArray
selectionSort(inputArray)
println("After Selection Sort")
inputArray
