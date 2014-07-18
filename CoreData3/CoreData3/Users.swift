import UIKit
// You need to import CoreData
import CoreData

@objc(Users) // <= Make the class available to Objective-C as Users
class Users: NSManagedObject {
    // NSManaged: It tells the compiler that these properties will be manage from CoreData
    @NSManaged var username:String
    @NSManaged var password:String
}
