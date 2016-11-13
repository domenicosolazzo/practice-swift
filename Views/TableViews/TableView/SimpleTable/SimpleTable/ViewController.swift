//
//  ViewController.swift
//  SimpleTable
//
//  Created by Domenico on 22.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    fileprivate let dwarves = [
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count
    }
    
    /// It is called by the table view when it needs to draw one of its rows.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse a cell of the specified type
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier) as UITableViewCell!
        if cell == nil{
            // Create a new cell if it does not exist
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: simpleTableIdentifier)
        }
        
        // Adding the images
        let image = UIImage(named: "star")
        let highlitedImage = UIImage(named: "star2")
        
        cell!.imageView?.image = image
        cell!.imageView?.highlightedImage = highlitedImage
        
        // Adding detailed text
        if (indexPath as NSIndexPath).row < 7 {
            cell!.detailTextLabel?.text = "Mr Disney"
        } else {
            cell!.detailTextLabel?.text = "Mr Tolkien"
        }
        
        cell!.textLabel!.text = dwarves[(indexPath as NSIndexPath).row]
        cell!.textLabel!.font = UIFont.boldSystemFont(ofSize: 50)
        return cell!
        
    }
    
    //- MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView,
        indentationLevelForRowAt
        indexPath: IndexPath) -> Int {
            return (indexPath as NSIndexPath).row % 4
    }
    // Before the row is selected
    func tableView(_ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath)
        -> IndexPath? {
            if (indexPath as NSIndexPath).row == 0 {
                return nil
            } else {
                return indexPath
            }
    }
    
    // After the row is selected
    func tableView(_ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            let rowValue = dwarves[(indexPath as NSIndexPath).row]
            let message = "You selected \(rowValue)"
            
            let controller = UIAlertController(title: "Row Selected",
                message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Yes I Did",
                style: .default, handler: nil)
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
    }
    
    // Customizing the row height
    func tableView(_ tableView: UITableView,
        heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            return (indexPath as NSIndexPath).row == 0 ? 120 : 70
    }


}

