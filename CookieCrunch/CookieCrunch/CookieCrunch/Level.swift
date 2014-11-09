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
    init(){
    }
    /// The property cookies is the two-dimensional array that holds the Cookie objects, 81 in total
    /// The cookies array is private, so Level needs to provide a way for others to obtain a cookie object at a specific position in the level grid
    private var cookies = Array2D<Cookie>(columns: NumColumns, rows: NumRows)
    
    /// Which part of the grid can contain a cookie
    private var tiles = Array2D<Tile>(columns: NumColumns, rows: NumRows)
    
    init(filename: String) {
        // Load the named file into a Dictionary using the loadJSONFromBundle()
        if let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename) {
            // The dictionary has an array named “tiles”. This array contains one element for each row of the level. Each of those row elements is itself an array containing the columns for that row.
            if let tilesArray: AnyObject = dictionary["tiles"] {
                // Step through the rows using built-in enumerate() function, which is useful because it also returns the current row number.
                for (row, rowArray) in enumerate(tilesArray as [[Int]]) {
                    // The first row you read from the JSON corresponds to the last row of the 2-D grid
                    let tileRow = NumRows - row - 1
                    // Step through the columns in the current row. Every time it finds a 1, it creates a Tile object and places it into the tiles array.
                    for (column, value) in enumerate(rowArray) {
                        if value == 1 {
                            tiles[column, tileRow] = Tile()
                        }
                    }
                }
            }
        }
    }
    
    func tileAtColumn(column: Int, row: Int) -> Tile? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return tiles[column, row]
    }
    
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
                if tiles[column, row] != nil {
                    // Then the method picks a random cookie type
                    var cookieType = CookieType.random()
                
                    // The method creates a new Cookie object and adds it to the 2-D array
                    let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                
                    // The method adds the new Cookie object to a Set. Shuffle returns this set of cookie objects to its caller
                    set.addElement(cookie)
                }
            }
        }
        return set
    }
    
    // The shuffle method fills up the level with random cookies
    func shuffle() -> Set<Cookie> {
        return createInitialCookies()
    }
}
