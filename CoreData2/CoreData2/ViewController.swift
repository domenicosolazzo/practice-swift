import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var txtFirstname: UITextField
    @IBOutlet var txtLastname: UITextField
    @IBOutlet var txtAge: UITextField
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSave(sender: UIButton) {
    }

    @IBAction func btnLoad(sender: UIButton) {
    }
}

