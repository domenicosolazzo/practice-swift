//
//  Array2D.swift
//  CookieCrunch
//
//  Created by Domenico on 11/8/14
//

// Struct is a generic
struct Array2D<T>{
    let columns:Int
    let rows:Int
    private var array : Array<T?>
    
    init(columns:Int, rows:Int){
        self.columns = columns
        self.rows = rows
        // It creates a regular Swift Array with a count of rows × columns and sets all these elements to nil.
        array = Array<T?>(count:rows*columns, repeatedValue:nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return self.array[row*columns + column]
        }
        set {
            self.array[row*columns + column] = newValue
        }
    }
}