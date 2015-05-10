//
//  ViewController.swift
//  Populate TableViews
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain)
        
        if let theTableView = tableView{
            // It takes a class name that denotes the type of object that you want your table view to load when it renders each cell (subclass of UITableViewCell) and a cell identifier.
            theTableView.registerClass(UITableViewCell.classForCoder(),
                forCellReuseIdentifier: "identifier")
            
            // It takes an object that conform to UITableViewDataSource
            theTableView.dataSource = self
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            // Add the table view as subview
            view.addSubview(theTableView)
        }
    }
}

