//
//  ViewController.swift
//  Headers and Footers in TableViews
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,
                        UITableViewDelegate {

    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        
        if let theTableView = tableView{
            theTableView.registerClass(
                UITableViewCell.classForCoder(),
                forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.delegate = self
            theTableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
            
            // Add the table view as subview
            self.view.addSubview(theTableView)
        }
    }
}

