import Foundation

class Array2D<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(count:rows * columns, repeatedValue: nil)
    }
    
    ///
    /// Custom subscript for Array2D: The subscript is capable of supporting array[column, row] 
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * columns) + column]
        }
        set(newValue) {
            array[(row * columns) + column] = newValue
        }
    }
    
}
