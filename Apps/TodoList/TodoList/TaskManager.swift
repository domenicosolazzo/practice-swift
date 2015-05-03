import UIKit

var taskManager = TaskManager()

// Task structure
struct Task{
    var name = "Un-Named"
    var desc = "Un-Described"
}

class TaskManager: NSObject {
    var tasks = Task[]()
    
    // Add a task
    func addTask(name:String, desc:String){
        tasks.append(Task(name:name, desc:desc))
    }
}
