let NumColumns = 10
let NumRows = 20
    
let StartingColumn = 4
let StartingRow = 0
    
let PreviewColumn = 12
let PreviewRow = 1

// Custom protocol
protocol SwiftrisDelegate {
    // Invoked when the current round of Swiftris ends
    func gameDidEnd(swiftris: SwifTris)
    
    // Invoked immediately after a new game has begun
    func gameDidBegin(swiftris: SwifTris)
    
    // Invoked when the falling shape has become part of the game board
    func gameShapeDidLand(swiftris: SwifTris)
    
    // Invoked when the falling shape has changed its location
    func gameShapeDidMove(swiftris: SwifTris)
    
    // Invoked when the falling shape has changed its location after being dropped
    func gameShapeDidDrop(swiftris: SwifTris)
    
    // Invoked when the game has reached a new level
    func gameDidLevelUp(swiftris: SwifTris)
}

class SwifTris{

    var blockArray:Array2D<Block>
    var nextShape:Shape?
    var fallingShape:Shape?
    /// The delegate will be notified of several events throughout the course of the game
    var delegate:SwiftrisDelegate?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        }
        delegate?.gameDidBegin(self)
    }
    
    /// Create a new shape before moving the falling shape
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        fallingShape?.moveTo(StartingColumn, row: StartingRow)
        
        /// now detect the ending of a Switris game. The game ends when a new shape located at the designated starting location collides with existing blocks. This is the case where the player no longer has enough room to move the new shape, and therefore, we must terminate their tower of terror.
        if detectIllegalPlacement() {
            nextShape = fallingShape
            nextShape!.moveTo(PreviewColumn, row: PreviewRow)
            endGame()
            return (nil, nil)
        }
        return (fallingShape, nextShape)
    }
    
    /// Function for checking both block boundary conditions. This first determines whether or not a block exceeds the legal size of the game board. The second determines whether or not a block's current location overlaps with an existing block.
    func detectIllegalPlacement() -> Bool {
        if let shape = fallingShape {
            for block in shape.blocks {
                if block.column < 0 || block.column >= NumColumns
                    || block.row < 0 || block.row >= NumRows {
                        return true
                } else if blockArray[block.column, block.row] != nil {
                    return true
                }
            }
        }
        return false
    }
    
    /// Function for ending the game
    func endGame() {
        delegate?.gameDidEnd(self)
    }
    
    
    /// Dropping a shape is the act of sending it plummeting towards the bottom of the game board.
    func dropShape() {
        if let shape = fallingShape {
            while detectIllegalPlacement() == false {
                shape.lowerShapeByOneRow()
            }
            shape.raiseShapeByOneRow()
            delegate?.gameShapeDidDrop(self)
        }
    }
    
    /// It lowers the shape by one row and ends the game if it fails to do so without finding legal placement for it.
    func letShapeFall() {
        if let shape = fallingShape {
            shape.lowerShapeByOneRow()
            if detectIllegalPlacement() {
                shape.raiseShapeByOneRow()
                if detectIllegalPlacement() {
                    endGame()
                } else {
                    settleShape()
                }
            } else {
                delegate?.gameShapeDidMove(self)
                if detectTouch() {
                    settleShape()
                }
            }
        }
    }
    
    func rotateShape() {
        if let shape = fallingShape {
            shape.rotateClockwise()
            if detectIllegalPlacement() {
                shape.rotateCounterClockwise()
            } else {
                delegate?.gameShapeDidMove(self)
            }
        }
    }
    
    func moveShapeLeft() {
        if let shape = fallingShape {
            shape.shiftLeftByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftRightByOneColumn()
                return
            }
            delegate?.gameShapeDidMove(self)
        }
    }
    
    
    func moveShapeRight() {
        if let shape = fallingShape {
            shape.shiftRightByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftLeftByOneColumn()
                return
            }
            delegate?.gameShapeDidMove(self)
        }
    }
    
    /// settleShape() adds the falling shape to the collection of blocks maintained by Swiftris. Once the falling shape's blocks are part of the game board, fallingShape is nullified and the delegate is notified of a new shape settling into the game board.
    func settleShape() {
        if let shape = fallingShape {
            for block in shape.blocks {
                blockArray[block.column, block.row] = block
            }
            fallingShape = nil
            delegate?.gameShapeDidLand(self)
        }
    }
    
    func detectTouch() -> Bool {
        if let shape = fallingShape {
            for bottomBlock in shape.bottomBlocks {
                if bottomBlock.row == NumRows - 1 ||
                    blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
                        return true
                }
            }
        }
        return false
    }
}