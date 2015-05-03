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
    
    var todoData:NSDictionary = NSDictionary()
    
    init(coder aDecoder: NSCoder!){
        super.init(coder: aDecoder)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiTextField.userInteractionEnabled = false
        uiTextView.userInteractionEnabled = false

        uiTextField.text = todoData.objectForKey("itemTitle") as String
        uiTextView.text = todoData.objectForKey("itemNotes") as String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteTask(sender: AnyObject) {
        var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        var mutableArray:NSMutableArray = NSMutableArray()
        
        for dict:AnyObject in itemList!{
            mutableArray.addObject(dict)
        }
        mutableArray.removeObject(todoData)
        
        userDefaults.removeObjectForKey("itemList")
        userDefaults.setObject(mutableArray, forKey: "itemList")
        
        userDefaults.synchronize()
        
        self.navigationController.popToRootViewControllerAnimated(true)
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
