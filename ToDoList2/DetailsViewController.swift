//
//  DetailsViewController.swift
//  ToDoList2
//
//  Created by Domenico Solazzo on 7/9/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

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
    
    @IBAction func deleteView(sender: AnyObject) {
        println("Deleted...");
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
