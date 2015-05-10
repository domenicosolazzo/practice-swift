//
//  ViewController.swift
//  Enabling Swipe deletion of TableViewCells
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController,
        UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView?
    
    var allRows:[String] = [String]()
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mock data
        for index in 1..<10{
            allRows.append("Row at index \(index)")
        }
        
        // Set the edit button 
        self.navigationItem.setLeftBarButtonItem(editButtonItem(), animated: true)
        
        // Create the table view
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
        
        if let theTableView = tableView{
            // Register the TableViewCell
            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.delegate = self
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            // Add the table view as subview
        }
    }
    
    //- MARK: UITableViewDataSource
    // Number of rows for section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRows.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = "Row \(indexPath.row)"
        return cell
    }
    
    //- MARK: UITableViewDelegate
    // It indicates if it is possible to insert or delete rows
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    // Get notified if a deletion has occurred
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Check if it is a delete
        if editingStyle == .Delete{
            // Remove the object from the source
            allRows.removeAtIndex(indexPath.row)
            // Remove the object from the table view using a Left animation
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
    }
    
    // Set editing
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView!.setEditing(editing, animated: animated)
    }
}

