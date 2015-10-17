//:Guard

import UIKit

let firstName = "D"
let lastName = "S"
let address = "A"
// "Early return" technique => BAD


if firstName != "" {
    if lastName != "" {
        if address != "" {
            // code awesomeness!
        }
    }
}

// Another "early return" technique
func earlyReturn() {
    if firstName == "" { return }
    if lastName == "" { return}
    if address == "" { return }
    // code awesonmeness
}
