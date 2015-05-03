import UIKit
// You need to import CoreData
import CoreData

@objc(Users) // <= Make the class available to Objective-C as Users
class Users: NSManagedObject {
    // NSManaged: It tells the compiler that these properties will be manage from CoreData
    @NSManaged var username:String
    @NSManaged var password:String
    
    // ToString method
    func ToString() -> String{
        return "The username is \(self.username) and the password is \(self.password)"
    }
    
    // Add prefix to the username
    func AddPrefix(prefix:String){
        self.username = "\(prefix)-" + self.username
    }
    
}
