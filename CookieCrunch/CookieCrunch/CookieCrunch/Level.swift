//
//  Level.swift
//  CookieCrunch
//
//  Created by Domenico on 11/9/14.
//

import Foundation
let NumColumns = 9
let NumRows = 9

class Level{
    /// The property cookies is the two-dimensional array that holds the Cookie objects, 81 in total 
    /// The cookies array is private, so Level needs to provide a way for others to obtain a cookie object at a specific position in the level grid
    private var cookies: Array2D<Cookie>(columns: NumColumns, rows:NumRows)
    
    func cookieAtColumn(column: Int, row: Int) -> Cookie? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return cookies[column, row]
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        var set = Set<Cookie>()
        
        // The method loops through the rows and columns of the 2-D array
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                
                // Then the method picks a random cookie type
                var cookieType = CookieType.random()
                
                // The method creates a new Cookie object and adds it to the 2-D array
                let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                cookies[column, row] = cookie
                
                // The method adds the new Cookie object to a Set. Shuffle returns this set of cookie objects to its caller
                set.addElement(cookie)
            }
        }
        return set
    }
    
    // The shuffle method fills up the level with random cookies
    func shuffle() -> Set<Cookie> {
        return createInitialCookies()
    }
}
