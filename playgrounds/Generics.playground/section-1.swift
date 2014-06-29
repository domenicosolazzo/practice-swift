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

func swapTwoValues<T>(inout a:T, inout b:T){
    let temporaryA = a
    a = b
    b = temporaryA
}
