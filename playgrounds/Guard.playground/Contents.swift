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

enum InputError:Error{
    case NameIsEmpty
    case TooYoung
    case IsiOS8
    case WrongAddress
}

// GUARD
func useGuard(name:String, age:Int, address:String?) throws {
    guard name.characters.count > 0 else {
        throw InputError.NameIsEmpty
    }
    
    guard age > 18 else {
        throw InputError.TooYoung
    }
    
    guard #available(iOS 9, *) else{
        throw InputError.IsiOS8
    }
    
    guard let unwrappedAddress = address else{
        throw InputError.WrongAddress
    }
    
    print(name, age, unwrappedAddress)
}


