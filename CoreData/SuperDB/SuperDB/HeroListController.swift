//
//  HeroListController.swift
//  SuperDB
//
//  Created by Domenico on 31/05/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

class HeroListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var heroTableView: UITableView!
    @IBOutlet weak var heroTabBar: UITabBar!
    
    override func viewDidLoad() {
        // Adding the editing button
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    //- MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeroListCell", forIndexPath: indexPath) as! UITableViewCell
        return cell
    }
}
