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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
    
    // Height for each Header
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    //- MARK: UITableViewDelegate
    // The view returned from this method will be displayed as the header of the section specified
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return newViewForHeaderOrFooterWithText("Section \(section) Header")
    }
    
    // The view returned from this method will be displayed as the footer of the section specified
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return newViewForHeaderOrFooterWithText("Section \(section) Footer")
    }
    
    //- MARK: Helpers
    func newLabelWithTitle(title:String) -> UILabel{
        var label = UILabel()
        label.text = title
        label.backgroundColor = UIColor.clearColor()
        label.sizeToFit()
        return label
    }
    
    func newViewForHeaderOrFooterWithText(text: String) -> UIView{
        let headerLabel = newLabelWithTitle(text)
        
        /* Move the label 10 points to the right */
        headerLabel.frame.origin.x += 10
        /* Go 5 points down in y axis */
        headerLabel.frame.origin.y = 5
        
        /* Give the container view 10 points more in width than our label
        because the label needs a 10 extra points left-margin */
        let resultFrame = CGRect(x: 0,
            y: 0,
            width: headerLabel.frame.size.width + 10,
            height: headerLabel.frame.size.height)
        
        let headerView = UIView(frame: resultFrame)
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
}

