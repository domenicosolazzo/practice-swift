//
//  ViewController.swift
//  lesson2
//
//  Created by Domenico Solazzo on 6/10/14.
//  Copyright (c) 2014 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section:    Int) -> Int {
        return 10 // A random number
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        cell.text = "Row #\(indexPath.row)"
        cell.detailTextLabel.text = "Subtitle #\(indexPath.row)"
        return cell
    }


}

