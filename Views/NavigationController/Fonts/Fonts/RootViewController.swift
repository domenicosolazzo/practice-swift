//
//  RootViewController.swift
//  Fonts
//
//  Created by Domenico on 23.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    fileprivate var familyNames: [String]!
    fileprivate var cellPointSize: CGFloat!
    fileprivate var favoritesList: FavoritesList!
    fileprivate let familyCell = "FamilyName"
    fileprivate let favoritesCell = "Favorites"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch all the fonts and sort them
        familyNames = (UIFont.familyNames ).sorted()
        // Preferred font for use in a headline
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        // Baseline font size
        cellPointSize = preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoriteList
    }
    
    // Just before it is implemented
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // It tells which fonts to show in a cell
    func fontForDisplay(atIndexPath indexPath: IndexPath) -> UIFont? {
        if (indexPath as NSIndexPath).section == 0 {
            let familyName = familyNames[(indexPath as NSIndexPath).row]
            // First font name within that family
            let fontName = UIFont.fontNames(forFamilyName: familyName).first
            if let font = fontName as String!{
                return UIFont(name: font, size: cellPointSize)
            }
            return nil
        } else {
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2
    }
    
    // Number of section for row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(_ tableView: UITableView,
        titleForHeaderInSection section: Int) -> String? {
            return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if (indexPath as NSIndexPath).section == 0 {
                // The font names list
                let cell = tableView.dequeueReusableCell(withIdentifier: familyCell,
                    for: indexPath) 
                cell.textLabel!.font = fontForDisplay(atIndexPath: indexPath)
                cell.textLabel!.text = familyNames[(indexPath as NSIndexPath).row]
                cell.detailTextLabel?.text = familyNames[(indexPath as NSIndexPath).row]
                return cell
            } else {
                // The favorites list
                return tableView.dequeueReusableCell(withIdentifier: favoritesCell,
                    for: indexPath)
            }
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let listVC = segue.destination as! FontListViewController
        
        if (indexPath as NSIndexPath).section == 0 {
            // Font names list
            let familyName = familyNames[(indexPath as NSIndexPath).row]
            listVC.fontNames = (UIFont.fontNames(forFamilyName: familyName) ).sorted()
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
