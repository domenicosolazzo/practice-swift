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
        familyNames = sorted(UIFont.familyNames() as! [String])
        // Preferred font for use in a headline
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        // Baseline font size
        cellPointSize = preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoriteList
    }
}
