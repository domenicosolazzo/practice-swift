//
//  LanguageListController.swift
//  Presidents
//
//  Created by Domenico on 26.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class LanguageListController: UITableViewController {
    weak var detailViewController: DetailViewController? = nil
    fileprivate let languageNames: [String] = ["English", "French", "German", "Spanish"]
    fileprivate let languageCodes: [String] = ["en", "fr", "de", "es"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearsSelectionOnViewWillAppear = false
        preferredContentSize = CGSize(width: 320, height: CGFloat(languageCodes.count * 44))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            
            return languageCodes.count
    }
    
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                for: indexPath) 
            
            // Configure the cell...
            cell.textLabel!.text = languageNames[(indexPath as NSIndexPath).row]
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            detailViewController?.languageString = languageCodes[(indexPath as NSIndexPath).row]
    }
}
