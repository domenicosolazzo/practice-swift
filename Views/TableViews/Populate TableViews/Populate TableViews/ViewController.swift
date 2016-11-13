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
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        
        if let theTableView = tableView{
            // It takes a class name that denotes the type of object that you want your table view to load when it renders each cell (subclass of UITableViewCell) and a cell identifier.
            theTableView.register(UITableViewCell.classForCoder(),
                forCellReuseIdentifier: "identifier")
            
            // It takes an object that conform to UITableViewDataSource
            theTableView.dataSource = self
            theTableView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
            
            // Add the table view as subview
            view.addSubview(theTableView)
        }
    }
    
    // Number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // Default is 1
    }
    
    // How many rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 3
        case 1:
            return 5
        case 2:
            return 8
        default:
            return 0
        }
    }
    
    // Return each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) 
        
        cell.textLabel!.text = "Section \((indexPath as NSIndexPath).section) -> Row \((indexPath as NSIndexPath).row)"
        return cell
    }
    
    // Prefers status bar hidden
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

