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
        self.navigationItem.setLeftBarButton(editButtonItem, animated: true)
        
        // Create the table view
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        
        if let theTableView = tableView{
            // Register the TableViewCell
            theTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.delegate = self
            theTableView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            
            // Add the table view as subview
            view.addSubview(theTableView)
        }
    }
    
    //- MARK: UITableViewDataSource
    // Number of rows for section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) 
        
        cell.textLabel!.text = "Row \((indexPath as NSIndexPath).row)"
        return cell
    }
    
    //- MARK: UITableViewDelegate
    // It indicates if it is possible to insert or delete rows
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    // Get notified if a deletion has occurred
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Check if it is a delete
        if editingStyle == .delete{
            // Remove the object from the source
            allRows.remove(at: (indexPath as NSIndexPath).row)
            // Remove the object from the table view using a Left animation
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        }
    }
    
    // Set editing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView!.setEditing(editing, animated: animated)
    }
}

