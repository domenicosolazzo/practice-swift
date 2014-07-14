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
        
    }
    
    @IBAction func btnSave(sender: UIButton) {
        
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

