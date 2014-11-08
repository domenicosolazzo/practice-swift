//
//  Cookie.swift
//  CookieCrunch
//
//  Created by Domenico on 11/8/14

import SpriteKit

enum CookieType: Int {
    case Unknown = 0, Croissant, Cupcake, Danish, Donut, Macaroon, SugarCookie
    
    var spriteName: String {
        let spriteNames = [
            "Croissant",
            "Cupcake",
            "Danish",
            "Donut",
            "Macaroon",
            "SugarCookie"]
        
        return spriteNames[rawValue - 1]
    }
    
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }
    
    // it will get a random cookie type
    static func random() -> CookieType {
        return CookieType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
}

class Cookie{
    var column:Int
    var row:Int
    let cookieType: CookieType
    var sprite:SKSpriteNode?
    
    init(column:Int, row:Int, cookieType:CookieType){
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
    
}
