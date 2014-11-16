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
    
    // List of possible swap
    private var possibleSwaps = Set<Swap>()

    
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
                    var cookieType: CookieType
                    // It makes sure that it never creates a chain of three or more
                    do {
                        cookieType = CookieType.random()
                    }
                    while ( // there are already two cookies of this type to the left
                            column >= 2 &&
                            cookies[column - 1, row]?.cookieType == cookieType &&
                            cookies[column - 2, row]?.cookieType == cookieType)
                            ||
                            // there are already two cookies of this type below
                            (row >= 2 &&
                            cookies[column, row - 1]?.cookieType == cookieType &&
                            cookies[column, row - 2]?.cookieType == cookieType
                    )
                
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
        var set: Set<Cookie>
        do {
            // fill up the level with random cookie objects
            set = createInitialCookies()
            // Detect the possible swaps
            detectPossibleSwaps()
            println("possible swaps: \(possibleSwaps)")
        }
            while possibleSwaps.count == 0
        
        return set
    }
    
    // Perform swap in the data model
    func performSwap(swap: Swap) {
        let columnA = swap.cookieA.column
        let rowA = swap.cookieA.row
        let columnB = swap.cookieB.column
        let rowB = swap.cookieB.row
        
        cookies[columnA, rowA] = swap.cookieB
        swap.cookieB.column = columnA
        swap.cookieB.row = rowA
        
        cookies[columnB, rowB] = swap.cookieA
        swap.cookieA.column = columnB
        swap.cookieA.row = rowB
    }
    
    // Check if a cookie is a part of a chain
    private func hasChainAtColumn(column: Int, row: Int) -> Bool {
        let cookieType = cookies[column, row]!.cookieType
        
        var horzLength = 1
        // Given a cookie in a particular square on the grid, this method first looks to the left. As long as it finds a cookie of the same type, it increments horzLength and keeps going left
        for var i = column - 1; i >= 0 && cookies[i, row]?.cookieType == cookieType;
            --i, ++horzLength { }
        for var i = column + 1; i < NumColumns && cookies[i, row]?.cookieType == cookieType;
            ++i, ++horzLength { }
        if horzLength >= 3 { return true }
        
        var vertLength = 1
        for var i = row - 1; i >= 0 && cookies[column, i]?.cookieType == cookieType;
            --i, ++vertLength { }
        for var i = row + 1; i < NumRows && cookies[column, i]?.cookieType == cookieType;
            ++i, ++vertLength { }
        return vertLength >= 3
    }
    
    // Detect possible swaps
    func detectPossibleSwaps() {
        var set = Set<Swap>()
        
        // It will step through the rows and columns of the 2-D grid and 
        // simply swap each cookie with the one next to it, one at a time
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let cookie = cookies[column, row] {
                    
                    // Is it possible to swap this cookie with the one on the right?
                    if column < NumColumns - 1 {
                        // Have a cookie in this spot? If there is no tile, there is no cookie.
                        if let other = cookies[column + 1, row] {
                            // Swap them
                            cookies[column, row] = other
                            cookies[column + 1, row] = cookie
                            
                            // Is either cookie now part of a chain?
                            if hasChainAtColumn(column + 1, row: row) ||
                                hasChainAtColumn(column, row: row) {
                                    set.addElement(Swap(cookieA: cookie, cookieB: other))
                            }
                            
                            // Swap them back
                            cookies[column, row] = cookie
                            cookies[column + 1, row] = other
                        }
                    }
                    
                    // Is it possible to swap this cookie with the one above?
                    if row < NumRows - 1 {
                        if let other = cookies[column, row + 1] {
                            cookies[column, row] = other
                            cookies[column, row + 1] = cookie
                            
                            // Is either cookie now part of a chain?
                            if hasChainAtColumn(column, row: row + 1) ||
                                hasChainAtColumn(column, row: row) {
                                    set.addElement(Swap(cookieA: cookie, cookieB: other))
                            }
                            
                            // Swap them back
                            cookies[column, row] = cookie
                            cookies[column, row + 1] = other
                        }
                    }
                }
            }
        }
        
        possibleSwaps = set
    }
    
    // Check if a swap is possible
    func isPossibleSwap(swap: Swap) -> Bool {
        return possibleSwaps.containsElement(swap)
    }
    
    // find the first cookie that starts a chain.
    private func detectHorizontalMatches() -> Set<Chain> {
        // new set to hold the horizontal chains
        var set = Set<Chain>()
        // loop through the rows and columns. 
        // Note that you don’t need to look at the last two columns because these cookies can never begin a new chain
        for row in 0..<NumRows {
            for var column = 0; column < NumColumns - 2 ; {
                
                if let cookie = cookies[column, row] {
                    let matchType = cookie.cookieType
                    // check whether the next two columns have the same cookie type
                    if cookies[column + 1, row]?.cookieType == matchType &&
                        cookies[column + 2, row]?.cookieType == matchType {
                            // there is a chain of at least three cookies but potentially there are more. This steps through all the matching cookies until it finds a cookie that breaks the chain or it reaches the end of the grid.
                            let chain = Chain(chainType: .Horizontal)
                            do {
                                chain.addCookie(cookies[column, row]!)
                                ++column
                            }
                                while column < NumColumns && cookies[column, row]?.cookieType == matchType
                            
                            set.addElement(chain)
                            continue
                    }
                }
                // If the next two cookies don’t match the current one or if there is an empty tile, then there is no chain, so you skip over the cookie
                ++column
            }
        }
        return set
    }
    
    private func detectVerticalMatches() -> Set<Chain> {
        var set = Set<Chain>()
        
        for column in 0..<NumColumns {
            for var row = 0; row < NumRows - 2; {
                if let cookie = cookies[column, row] {
                    let matchType = cookie.cookieType
                    
                    if cookies[column, row + 1]?.cookieType == matchType &&
                        cookies[column, row + 2]?.cookieType == matchType {
                            
                            let chain = Chain(chainType: .Vertical)
                            do {
                                chain.addCookie(cookies[column, row]!)
                                ++row
                            }
                                while row < NumRows && cookies[column, row]?.cookieType == matchType
                            
                            set.addElement(chain)
                            continue
                    }
                }
                ++row
            }
        }
        return set
    }
    
    func removeMatches() -> Set<Chain> {
        let horizontalChains = detectHorizontalMatches()
        let verticalChains = detectVerticalMatches()
        
        removeCookies(horizontalChains)
        removeCookies(verticalChains)
        
        return horizontalChains.unionSet(verticalChains)
    }
    
    
    // Remove the cookies from the level
    private func removeCookies(chains: Set<Chain>) {
        for chain in chains {
            for cookie in chain.cookies {
                cookies[cookie.column, cookie.row] = nil
            }
        }
    }
    
    // It detects where there are empty tiles and shifts any cookies down to fill up those tiles. 
    // It starts at the bottom and scans upward.
    func fillHoles() -> [[Cookie]] {
        var columns = [[Cookie]]()
        // loop through the rows, from bottom to top
        for column in 0..<NumColumns {
            var array = [Cookie]()
            for row in 0..<NumRows {
                // If there’s a tile at a position but no cookie, then there’s a hole
                if tiles[column, row] != nil && cookies[column, row] == nil {
                    // You scan upward to find the cookie that sits directly above the hole. 
                    // Note that the hole may be bigger than one square (for example, if this was a vertical chain) and 
                    // that there may be holes in the grid shape
                    for lookup in (row + 1)..<NumRows {
                        if let cookie = cookies[column, lookup] {
                            // If you find another cookie, move that cookie to the hole
                            cookies[column, lookup] = nil
                            cookies[column, row] = cookie
                            cookie.row = row
                            // You add the cookie to the array. 
                            // Each column gets its own array and cookies that are lower on 
                            // the screen are first in the array
                            array.append(cookie)
                            // Once you’ve found a cookie, you don’t need to scan up any farther so you 
                            // break out of the inner loop
                            break
                        }
                    }
                }
            }
            if !array.isEmpty {
                columns.append(array)
            }
        }
        return columns
    }
    
    // It adds new cookies to fill the columns to the top
    func topUpCookies() -> [[Cookie]] {
        var columns = [[Cookie]]()
        var cookieType: CookieType = .Unknown
        
        for column in 0..<NumColumns {
            var array = [Cookie]()
            // loop through the column from top to bottom
            for var row = NumRows - 1; row >= 0 && cookies[column, row] == nil; --row {
                // You ignore gaps in the level, because you only need to fill up grid squares that have a tile
                if tiles[column, row] != nil {
                    // You randomly create a new cookie type
                    var newCookieType: CookieType
                    do {
                        newCookieType = CookieType.random()
                    } while newCookieType == cookieType
                    cookieType = newCookieType
                    // It creates the new Cookie object and add it to the array for this column
                    let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                    array.append(cookie)
                }
            }
            
            if !array.isEmpty {
                columns.append(array)
            }
        }
        return columns
    }
    
}
