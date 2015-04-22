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
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        }
        
        // Adding the images
        let image = UIImage(named: "star")
        let highlitedImage = UIImage(named: "star2")
        
        cell!.imageView?.image = image
        cell!.imageView?.highlightedImage = highlitedImage
        cell!.textLabel!.text = dwarves[indexPath.row]
        return cell!
        
    }
    
    //- MARK: UITableViewDelegate


}

