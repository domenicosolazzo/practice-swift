// LinkedList
// Source: http://goo.gl/ysg92v

import Foundation

// Double LinkedList structure
class LLNode<T> {
    var key: T?
    var next: LLNode?
    var previous: LLNode?
}

public class LinkedList<T: Equatable>{

    // create a new LLNode instance
    private var head: LLNode<T> = LLNode<T>()
    
    // The number of linked items
    var count: Int{
        get{
            if (head.key == nil) {
                return 0
            }else{
                var current: LLNode = head
                var result: Int = 1
                
                while ((current.next) != nil) {
                    current = current.next!
                    result++
                }
                return result
            }
        }
    }
    
    // Append a new item to a linked list
    func addLink(key:T){
        // establish the head node
        if (head.key == nil) {
            head.key = key
            return;
        }
        
        // establish the iteration variables
        var current: LLNode? = head
        
        while (current != nil) {
            if (current?.next == nil) {
                
                var childToUse: LLNode = LLNode<T>()
                
                childToUse.key = key
                childToUse.previous = current
                current!.next = childToUse
                break;
            }
            
            current = current?.next
        }
    }
    
    // Remove a link at a specific index
    func removeLinkAtIndex(index: Int){
        
        var current: LLNode<T>? = head
        var trailer: LLNode<T>?
        var listIndex: Int = 0
        
        // Determine if the removal is at the head
        if (index == 0){
            current = current?.next
            head = current!
            return
        }
        
        // Iterate through the remaining items
        while (current != nil){
            
            if (listIndex == index){
                // Redirect the trailer and next pointers
                trailer!.next = current?.next
                current = nil
                break
            }
            
            // Update the assignments
            trailer = current
            current = current?.next
            listIndex++
        }
    }
    
    // Print all keys for the class
    func printAllKeys(){
        var current: LLNode! = head
        
        // assign the next instance
        while (current != nil) {
            println("link item is: \(current.key)")
            current = current.next
        }
    }
}