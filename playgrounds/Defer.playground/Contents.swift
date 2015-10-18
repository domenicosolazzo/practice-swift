//: Defer

import UIKit

// This is how you would write the code before. If the guard statement was failing, 
// the file would be open
/**
func writeLog() {
    let file = openFile()
    
    let hardwareStatus = fetchHardwareStatus()
    guard hardwareStatus != "disaster" else { return }
    file.write(hardwareStatus)
    
    let softwareStatus = fetchSoftwareStatus()
    guard softwareStatus != "disaster" else { return }
    file.write(softwareStatus)
    
    let networkStatus = fetchNetworkStatus()
    guard neworkStatus != "disaster" else { return }
    file.write(networkStatus)
    
    closeFile(file)
}
*/



