import UIKit
import CoreData

class ViewController: UIViewController {
                            
    @IBOutlet var txtUsername: UITextField = UITextField()
    @IBOutlet var txtPassword: UITextField = UITextField()
    
    @IBAction func btnLoad(sender: UIButton) {
        // Fetch the app delegate
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Fetch the context
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Create a new user
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        newUser.setValue(txtUsername.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")
        
        // Save the new object
        context.save(nil)
        
        println(newUser)
        println("User saved!")
    }
    
    @IBAction func btnSave(sender: UIButton) {
        // Fetch the app delegate
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        // Fetch the context
        var context: NSManagedObjectContext = appDel.managedObjectContext
        
        // Request for CoreData
        var request:NSFetchRequest = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false // TODO: learn about this property
        
        // Execute the request
        var results: NSArray = context.executeFetchRequest(request, error: nil)
        
        if(results.count > 0){
            for res in results{
                println(res)
            }
        }else{
            println("No user in the database. Save your first!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

