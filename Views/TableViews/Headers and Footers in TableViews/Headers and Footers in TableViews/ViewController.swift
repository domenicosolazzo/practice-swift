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
    
    //- MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
    
    //- MARK: UITableViewDelegate
    // The view returned from this method will be displayed as the header of the section specified
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
    }
    
    // The view returned from this method will be displayed as the footer of the section specified
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        <#code#>
    }
    
    //- MARK: Helpers
    func newLabelWithTitle(title:String) -> UILabel{
        var label = UILabel()
        label.text = title
        label.backgroundColor = UIColor.clearColor()
        label.sizeToFit()
        return label
    }
    
}

