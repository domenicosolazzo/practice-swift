//
//  FavoritesList.swift
//  Fonts
//
//  Created by Domenico on 23.04.15.
//

import UIKit
import Foundation

class FavoritesList{
    
    //  Swift does not support class properties unless they are of the computed type. (...yet!)
    class var sharedFavoriteList : FavoritesList {
        struct Singleton {
            static let instance = FavoritesList()
        }
        return Singleton.instance;
    }
    
    // We want external classed to be able to get this variables, but not modifying it.
    // private(set)
    private(set) var favorites: [String]
    
    init(){
        // Open the user defaults
        let defaults = NSUserDefaults.standardUserDefaults()
        // Look for the key 'favorites'
        let storedFavorites = defaults.objectForKey("favorites") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    
    private func saveFavorites(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favorites, forKey: "favorites")
        defaults.synchronize()
    }
    
    func addFavorite(fontName: String) {
        if (!favorites.contains(fontName)) {
            favorites.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFavorite(fontName: String) {
        if let index = favorites.indexOf(fontName) {
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int) {
        let item = favorites[from]
        favorites.removeAtIndex(from)
        favorites.insert(item, atIndex: to)
        saveFavorites()
    }
}
