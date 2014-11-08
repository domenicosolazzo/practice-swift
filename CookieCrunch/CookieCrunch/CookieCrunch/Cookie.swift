//
//  Cookie.swift
//  CookieCrunch
//
//  Created by Domenico on 11/8/14

import SpriteKit

enum CookieType: Int {
    case Unknown = 0, Croissant, Cupcake, Danish, Donut, Macaroon, SugarCookie
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
