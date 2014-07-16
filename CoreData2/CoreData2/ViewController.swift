import UIKit

// Document Directory
let documentFileFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
// File name
let fileName = "/file.txt"
// Path for the filename
let path = documentFileFolder.stringByAppendingString(fileName)

class ViewController: UIViewController {
                            
    @IBOutlet var txtFirstname: UITextField
    @IBOutlet var txtLastname: UITextField
    @IBOutlet var txtAddress: UITextField
    
    @IBOutlet var txtDescription: UITextView
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func bntLoad(sender: UIButton) {
    }
    @IBAction func btnSave(sender: UIButton) {
    }
}

