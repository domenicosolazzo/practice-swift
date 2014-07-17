import UIKit

// User directory path
let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
// Filename
let filename = "/file.txt"
// File path
let filePath = path.stringByAppendingString(filename)

class ViewController: UIViewController {
                            
    @IBOutlet var txtFirstname: UITextField
    @IBOutlet var txtLastname: UITextField
    @IBOutlet var txtAge: UITextField
    @IBOutlet var theMessage: UILabel
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSave(sender: UIButton) {
        var firstname = txtFirstname.text as String
        var lastname = txtLastname.text as String
        var age = txtAge.text as String
        
        var message = "The info: \(firstname) \(lastname) is \(age) years old"
        
        // FileManager
        var fileManager = NSFileManager.defaultManager()
        
        // Check if the file exists
        if(!fileManager.fileExistsAtPath(filePath)){
            // The NSError in case there is an error writing the file
            var writeError: NSError?
            // Write the file
            message.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding, error: &writeError)
            
            // Check if there is an error writing the file
            if writeError == nil{
                println("No errors. We could write the file")
            }else{
                println("We have encountered an error writing the file. \(writeError)")
            }
            
        }else{
            println("The file already exists")
        }
        
        // Remove the keyboard
        txtFirstname.resignFirstResponder()
        txtLastname.resignFirstResponder()
        txtAge.resignFirstResponder()
        
    }

    @IBAction func btnLoad(sender: UIButton) {
        var err:NSError?
        // Reading the file
        var message = String.stringWithContentsOfFile(filePath, encoding: NSUTF8StringEncoding, error: &err)
        
        // Checking if there is an error reading the file
        if err == nil{
            theMessage.text = message
        }else{
            println("Error reading the file \(err)")
            theMessage.text = "Error reading the file: \(err)"
        }
    }
}

