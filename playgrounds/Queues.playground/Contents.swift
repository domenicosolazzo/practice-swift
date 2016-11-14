// Queue Data Structure
// Source:

public class QNode<T> {
    var key: T?
    var next: QNode?
}

public class Queue<T> {
    private var top: QNode<T>! = QNode<T>()
    
    // Enqueue the specified object
    func enQueue( key: T){
        
        // Check for the instance
        let key = key
        if (top == nil) {
            top = QNode<T>()
        }
        
        // establish the top node
        if (top.key == nil) {
            top.key = key
            return
        }
        
        let childToUse: QNode<T> = QNode<T>()
        var current: QNode = top
        
        // cycle through the list of items to get to the end.
        while (current.next != nil) {
            current = current.next!
        }
        
        // Append a new item
        childToUse.key = key
        current.next = childToUse
    }
    
    // Retrieve items from the top level
    func deQueue() -> T? {
        // Determine if the key or instance exists
        let topitem: T? = self.top?.key
        
        if (topitem == nil) {
            return nil
        }
        
        // Retrieve and queue the next item
        let queueitem: T? = top.key!
        
        // Use optional binding
        if let nextitem = top.next {
            top = nextitem
        }else{
            top = nil
        }
        
        return queueitem
    }
    
    // Check for the presence of a value
    func isEmpty() -> Bool {
        // Determine if the key or instance
        if let _: T = self.top?.key {
            return false
        }else {
            return true
        }
    }
    
    // Retrieve the top most item
    func peek() -> T? {
        return top.key!
    }
}
