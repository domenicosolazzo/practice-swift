//
//  ViewController.swift
//  SimpleTable
//
//  Created by Domenico on 22.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let dwarves = [
        "Sleepy", "Sneezy", "Bashful", "Happy",
        "Doc", "Grumpy", "Dopey",
        "Thorin", "Dorin", "Nori", "Ori",
        "Balin", "Dwalin", "Fili", "Kili",
        "Oin", "Gloin", "Bifur", "Bofur",
        "Bombur"
    ]
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //- MARK: UITableViewDataSource
    /// Number of row in a section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count
    }
    
    /// It is called by the table view when it needs to draw one of its rows.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Reuse a cell of the specified type
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        if cell == nil{
            // Create a new cell if it does not exist
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: simpleTableIdentifier)
        }
        
        // Adding the images
        let image = UIImage(named: "star")
        let highlitedImage = UIImage(named: "star2")
        
        cell!.imageView?.image = image
        cell!.imageView?.highlightedImage = highlitedImage
        
        // Adding detailed text
        if indexPath.row < 7 {
            cell!.detailTextLabel?.text = "Mr Disney"
        } else {
            cell!.detailTextLabel?.text = "Mr Tolkien"
        }
        
        cell!.textLabel!.text = dwarves[indexPath.row]
        cell!.textLabel!.font = UIFont.boldSystemFontOfSize(50)
        return cell!
        
    }
    
    //- MARK: UITableViewDelegate
    func tableView(tableView: UITableView,
        indentationLevelForRowAtIndexPath
        indexPath: NSIndexPath) -> Int {
            return indexPath.row % 4
    }
    // Before the row is selected
    func tableView(tableView: UITableView,
        willSelectRowAtIndexPath indexPath: NSIndexPath)
        -> NSIndexPath? {
            if indexPath.row == 0 {
                return nil
            } else {
                return indexPath
            }
    }
    
    // After the row is selected
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let rowValue = dwarves[indexPath.row]
            let message = "You selected \(rowValue)"
            
            let controller = UIAlertController(title: "Row Selected",
                message: message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "Yes I Did",
                style: .Default, handler: nil)
            controller.addAction(action)
            
            presentViewController(controller, animated: true, completion: nil)
    }
    
    // Customizing the row height
    func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath)
        -> CGFloat {
            return indexPath.row == 0 ? 120 : 70
    }


}

