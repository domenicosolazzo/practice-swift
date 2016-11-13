//
//  FontSizesViewController.swift
//  Fonts
//
//  Created by Domenico on 23.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController {

    var font: UIFont!
    fileprivate var pointSizes: [CGFloat] {
        struct Constants {
            static let pointSizes: [CGFloat] = [
                9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144
            ]
        }
        return Constants.pointSizes
    }
    fileprivate let cellIdentifier = "FontNameAndSize"
    
    func fontForDisplay(atIndexPath indexPath: IndexPath) -> UIFont {
        let pointSize = pointSizes[(indexPath as NSIndexPath).row]
        return font.withSize(pointSize)
    }
    
    override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            // Return the number of rows in the section.
            return pointSizes.count
            
    }
    
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) 
            
            cell.textLabel!.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel!.text = font.fontName
            cell.detailTextLabel?.text = "\(pointSizes[(indexPath as NSIndexPath).row]) point"
            
            return cell
    }
    
  
}
