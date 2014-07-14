import UIKit
import CoreData

class ViewController: UIViewController {
                            
    @IBOutlet var txtUsername: UITextField = UITextField()
    @IBOutlet var txtPassword: UITextField = UITextField()
    
    @IBAction func btnLoad(sender: UIButton) {
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context: NSManagedObjectContext = appDel.managedObjectContext
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

