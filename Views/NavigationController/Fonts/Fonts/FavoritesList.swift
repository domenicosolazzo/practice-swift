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
    fileprivate(set) var favorites: [String]
    
    init(){
        // Open the user defaults
        let defaults = UserDefaults.standard
        // Look for the key 'favorites'
        let storedFavorites = defaults.object(forKey: "favorites") as? [String]
        favorites = storedFavorites != nil ? storedFavorites! : []
    }
    
    fileprivate func saveFavorites(){
        let defaults = UserDefaults.standard
        defaults.set(favorites, forKey: "favorites")
        defaults.synchronize()
    }
    
    func addFavorite(_ fontName: String) {
        if (!favorites.contains(fontName)) {
            favorites.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFavorite(_ fontName: String) {
        if let index = favorites.index(of: fontName) {
            favorites.remove(at: index)
            saveFavorites()
        }
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int) {
        let item = favorites[from]
        favorites.remove(at: from)
        favorites.insert(item, at: to)
        saveFavorites()
    }
}
