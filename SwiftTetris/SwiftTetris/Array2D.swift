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
    
    
}
