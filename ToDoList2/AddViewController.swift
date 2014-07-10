
import UIKit

class AddViewController: UIViewController {

    @IBOutlet var uiTextField: UITextField
    @IBOutlet var uiTextView: UITextView
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemList:NSMutableArray? =  userDefaults.objectForKey("itemList") as? NSMutableArray
        
        var dataSet:NSMutableDictionary = NSMutableDictionary()
        dataSet.setObject(uiTextField.text, forKey: "itemTitle")
        dataSet.setObject(uiTextView.text, forKey: "itemNotes")
        
        if(itemList){ // data already available
            var newMutableArray = NSMutableArray()
        
            for dict:AnyObject in itemList!{
                newMutableArray.addObject(dict)
            }
            newMutableArray.addObject(dataSet)
            
            self.ResetAndInitializeData(userDefaults, data:newMutableArray)
        
        }else{ // First item of the list
            itemList = NSMutableArray()
            itemList!.addObject(dataSet)
            
            self.ResetAndInitializeData(userDefaults, data:itemList)
        }
        
        userDefaults.synchronize()
        
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func ResetAndInitializeData(userDefaults:NSUserDefaults, data:NSMutableArray!){
        userDefaults.removeObjectForKey("itemList")
        userDefaults.setObject(data, forKey: "itemList")
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
