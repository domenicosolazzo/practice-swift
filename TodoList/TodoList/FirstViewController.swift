//
//  FirstViewController.swift
//  TodoList
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
                            
    @IBOutlet var tblTask: UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Reload the data when the view appear
    override func viewWillAppear(animated: Bool) {
        tblTask.reloadData()
        // Reloading the data will fire the events for the table view below
    }
    
    // UITableViewDelegate
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            taskManager.tasks.removeAtIndex(indexPath.row)
            tblTask.reloadData()
        }
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return taskManager.tasks.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        
        let cell: UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"Default")
        
        cell.text = taskManager.tasks[indexPath.row].name
        cell.detailTextLabel.text = taskManager.tasks[indexPath.row].desc
        
        return cell
    }
    


}

