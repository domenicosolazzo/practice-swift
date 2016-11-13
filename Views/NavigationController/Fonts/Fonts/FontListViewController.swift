//
//  FontListViewController.swift
//  Fonts
//
//  Created by Domenico on 23.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    var fontNames: [String] = []
    var showsFavorites:Bool = false
    fileprivate var cellPointSize: CGFloat!
    fileprivate let cellIdentifier = "FontName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showsFavorites {
            navigationItem.rightBarButtonItem = editButtonItem
        }
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
    }
    
    // Fetch the font names
    func fontForDisplay(atIndexPath indexPath: IndexPath) -> UIFont {
        let fontName = fontNames[(indexPath as NSIndexPath).row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavorites {
            fontNames = FavoritesList.sharedFavoriteList.favorites
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return fontNames.count
    }
    
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                for: indexPath) 
            
            cell.textLabel!.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel!.text = fontNames[(indexPath as NSIndexPath).row]
            cell.detailTextLabel?.text = fontNames[(indexPath as NSIndexPath).row]
            
            return cell
    }
    
    // Accepted editing
    override func tableView(_ tableView: UITableView,
        canEditRowAt indexPath: IndexPath) -> Bool {
            return showsFavorites
    }
    
    // Deleting a row
    override func tableView(_ tableView: UITableView,
        commit editingStyle: UITableViewCellEditingStyle,
        forRowAt indexPath: IndexPath) {
            if !showsFavorites {
                return
            }
            
            if editingStyle == UITableViewCellEditingStyle.delete {
                // Delete the row from the data source
                let favorite = fontNames[(indexPath as NSIndexPath).row]
                FavoritesList.sharedFavoriteList.removeFavorite(favorite)
                fontNames = FavoritesList.sharedFavoriteList.favorites
                
                tableView.deleteRows(at: [indexPath],
                    with: UITableViewRowAnimation.fade)
            }
    }
    
    // Reordering function
    override func tableView(_ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath) {
            FavoritesList.sharedFavoriteList.moveItem(fromIndex: (sourceIndexPath as NSIndexPath).row,
                toIndex: (destinationIndexPath as NSIndexPath).row)
            fontNames = FavoritesList.sharedFavoriteList.favorites
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: tableViewCell)!
        let font = fontForDisplay(atIndexPath: indexPath)
        
        if segue.identifier == "ShowFontSizes" {
            let sizesVC =  segue.destination as! FontSizesViewController
            sizesVC.title = font.fontName
            sizesVC.font = font
        } else {
            let infoVC = segue.destination as! FontInfoViewController
            infoVC.font = font
            infoVC.favorite = FavoritesList.sharedFavoriteList.favorites.contains(font.fontName)
        }
    }
}
