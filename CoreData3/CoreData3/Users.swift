import UIKit
// You need to import CoreData
import CoreData

class Users: NSManagedObject {
    // NSManaged: It tells the compiler that these properties will be manage from CoreData
    @NSManaged var username:String
    @NSManaged var password:String
}
