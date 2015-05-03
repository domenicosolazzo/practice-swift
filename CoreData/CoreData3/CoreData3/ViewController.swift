import UIKit
import CoreData

class ViewController: UIViewController {
                            
    @IBOutlet var txtUsername: UITextField
    @IBOutlet var txtLastname: UITextField
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoad(sender: UIButton) {
        // Fetch the AppDelegate
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Fetch the NSManagedObjectContext
        var context:NSManagedObjectContext = appDel.managedObjectContext as NSManagedObjectContext
        
        // Create a request
        var request:NSFetchRequest = NSFetchRequest(entityName: "Users")
        // Return a list of objects that we are looking for
        request.returnsObjectsAsFaults = false
        
        // Create a predicate(filter) for the request
        request.predicate = NSPredicate(format: "username = %@", txtUsername.text)
        
        // Execute the request
        var results = context.executeFetchRequest(request, error: nil)
        
        if results.count > 0{
        
            for res in results{
                var user = res as Users
                println("User: \(user.username), \(user.password)")
                println(user.ToString())
                user.AddPrefix("YoYo")
                println(user.ToString())
            }
            println("Found \(results.count) results!")
        }else{
            println("No result found!")
        }
        
    }
    @IBAction func btnSave(sender: UIButton) {
        
        // Fetch the AppDelegate
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Fetch the NSManagedObjectContext
        var context:NSManagedObjectContext = appDel.managedObjectContext as NSManagedObjectContext
        
        // Fetch the user entities
        let ent = NSEntityDescription.entityForName("Users", inManagedObjectContext: context)
        
        // Create a new user object
        var newUser = Users(entity: ent, insertIntoManagedObjectContext: context)
        newUser.username = txtUsername.text
        newUser.password = txtLastname.text
        
        //Save the object
        context.save(nil)
        
        //Print the object
        println(newUser)
        
    }

}

