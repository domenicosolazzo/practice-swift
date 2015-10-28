//
//  RootViewController.swift
//  Fonts
//
//  Created by Domenico on 23.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoritesList: FavoritesList!
    private let familyCell = "FamilyName"
    private let favoritesCell = "Favorites"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch all the fonts and sort them
        familyNames = (UIFont.familyNames() ).sort()
        // Preferred font for use in a headline
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        // Baseline font size
        cellPointSize = preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoriteList
    }
    
    // Just before it is implemented
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // It tells which fonts to show in a cell
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            // First font name within that family
            let fontName = UIFont.fontNamesForFamilyName(familyName).first
            if let font = fontName as String!{
                return UIFont(name: font, size: cellPointSize)
            }
            return nil
        } else {
            return nil
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2
    }
    
    // Number of section for row
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
            return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                // The font names list
                let cell = tableView.dequeueReusableCellWithIdentifier(familyCell,
                    forIndexPath: indexPath) 
                cell.textLabel!.font = fontForDisplay(atIndexPath: indexPath)
                cell.textLabel!.text = familyNames[indexPath.row]
                cell.detailTextLabel?.text = familyNames[indexPath.row]
                return cell
            } else {
                // The favorites list
                return tableView.dequeueReusableCellWithIdentifier(favoritesCell,
                    forIndexPath: indexPath)
            }
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        let listVC = segue.destinationViewController as! FontListViewController
        
        if indexPath.section == 0 {
            // Font names list
            let familyName = familyNames[indexPath.row]
            listVC.fontNames = (UIFont.fontNamesForFamilyName(familyName) ).sort()
            listVC.navigationItem.title = familyName
            listVC.showsFavorites = false
        } else {
            // Favorites list
            listVC.fontNames = favoritesList.favorites
            listVC.navigationItem.title = "Favorites"
            listVC.showsFavorites = true
        }
    }
}
