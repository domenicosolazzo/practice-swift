let NumColumns = 10
let NumRows = 20
    
let StartingColumn = 4
let StartingRow = 0
    
let PreviewColumn = 12
let PreviewRow = 1

class SwifTris{

    var blockArray:Array2D<Block>
    var nextShape:Shape?
    var fallingShape:Shape?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        }
    }
}