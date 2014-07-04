//
//  FirstViewController.swift
//  TodoList
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

