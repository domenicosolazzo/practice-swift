import Foundation

class BlockStatus {
    var isRunning = false
    // How long before this block should be running
    var timeGapForNextRun = UInt32(0)
    // How long the block waited
    var currentInterval = UInt32(0)
    
    init(isRunning:Bool, timeGapForNextRun:UInt32, currentInterval:UInt32) {
        self.isRunning = isRunning
        self.timeGapForNextRun = timeGapForNextRun
        self.currentInterval = currentInterval
    }
    
    func shouldRunBlock() -> Bool {
        return self.currentInterval > self.timeGapForNextRun
    }
}