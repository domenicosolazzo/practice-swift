//
//  PlacesTableViewController.swift
//  UITableViewCell Customization
//
//  Created by Domenico on 07/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {

    let data = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.places.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PlacesTableViewCell
        let entry = data.places[indexPath.row]
        let image = UIImage(named: entry.filename)
        cell.cellImageView.image = image
        cell.cellLabel.text = entry.heading
        return cell
    }

}
