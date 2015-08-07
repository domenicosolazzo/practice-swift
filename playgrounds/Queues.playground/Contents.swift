// Queue Data Structure
// Source:

public class QNode<T> {
    var key: T?
    var next: QNode?
}

public class Queue<T> {
    private var top: QNode<T>! = QNode<T>()
    
    // Enqueue the specified object
    func enQueue(var key: T){
        
        // Check for the instance
        if (top == nil) {
            top = QNode<T>()
        }
        
        // establish the top node
        if (top.key == nil) {
            top.key = key
            return
        }
        
        var childToUse: QNode<T> = QNode<T>()
        var current: QNode = top
        
        // cycle through the list of items to get to the end.
        while (current.next != nil) {
            current = current.next!
        }
        
        // Append a new item
        childToUse.key = key
        current.next = childToUse
    }
}