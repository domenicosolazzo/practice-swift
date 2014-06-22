/* Closure
Closures are self-contained blocks of functionality that can be passed
around and used in your code. Closures in Swift are similar to blocks in C
and Objective-C and to lambdas in other programming languages.
*/
import Cocoa

/*
====== Closure Expression ======

{ (parameters) -> return type in
    statements
}
*/

var names = ["Domenico", "Marco", "Antonio"]

var reversed = sort(names, { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// It could be also written in a single line
reversed = sort(names, { (s1: String, s2: String) -> Bool in return s1 > s2})

/*
====== Inferring Type from Context ======
Swift can infer the type of the parameters and the returned type
*/
reversed = sort(names, {s1, s2 in return s1>s2})

/*
====== Implicit return from a Single-Expression closure ======
*/
reversed = sort(names, {s1, s2 in s1>s2 })

/*
====== Shorthand Argument names ======
Swift automatically provides shorthand argument names to inline closures, 
which can be used to refer to the values of the closure’s arguments by the names $0, $1, $2, and so on.
*/
reversed = sort(names, {$0 > $1})

/*
====== Operator function ======
*/
reversed = sort(names, >)

/*
====== Trailing closures ======
*/
func someFunctionThatTakesAClosure(closure: () -> ()) {
    // function body goes here
}

// Calling this function without a trailing closure
someFunctionThatTakesAClosure({
        // function body goes here
})

// Calling this fuction with a trailing closure
someFunctionThatTakesAClosure(){
    // function body goes here
}
