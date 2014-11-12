//
//  Swap.swift
//  CookieCrunch
//
//  Created by Domenico on 11/12/14.
//

struct Swap:Printable{
    let cookieA: Cookie
    let cookieB: Cookie
    
    init(cookieA: Cookie, cookieB: Cookie) {
        self.cookieA = cookieA
        self.cookieB = cookieB
    }
    
    var description: String {
        return "swap \(cookieA) with \(cookieB)"
    }
}