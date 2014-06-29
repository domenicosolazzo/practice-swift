// Playground: Extensions
/**
Extensions add new functionality to an existing class, structure, or
enumeration type. This includes the ability to extend types for which you
do not have access to the original source code (known as retroactive
modeling). Extensions are similar to categories in Objective-C. (Unlike
Objective-C categories, Swift extensions do not have names.)
*/
import Cocoa

/*
=== Computed Properties ===
*/
extension Double{
    var km: Double {return self * 1_000.0}
    var m: Double {return self}
    var cm: Double {return self/100.0}
    var mm: Double {return self / 1_000.0}
    var ft: Double {return self/3.28084}
}

let oneInch = 25.4.mm

/*
=== Initializers ===
*/
struct Rect{
    var origin: Double = 0.0
    var size: Double = 0.0
}

let defaultRect = Rect()

extension Rect{
    init(o:Double, s:Double){
        self.origin = o
        self.size = s
    }
}

let newRect = Rect(o: 2.0, s: 4.5)


/*
=== Methods ===
*/
extension Int{
    func repetitions(task:()->()){
        for i in 0..self{
            task()
        }
    }
}

3.repetitions({ println("Hello!")})
3.repetitions({ println("Goodbye!")})

