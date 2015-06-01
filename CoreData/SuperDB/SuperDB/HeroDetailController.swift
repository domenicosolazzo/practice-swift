//
//  HeroDetailController.swift
//  SuperDB
//
//  Created by Domenico on 01/06/15.
//  License MIT
//

import UIKit
import CoreData

class HeroDetailController: UITableViewController {

    enum HeroEditControllerSections:Int {
        case Name
        case General
        case Count
    }
    
    enum HeroEditControllerName:Int {
        case Row
        case Count
    }
    
    enum HeroEditControllerGeneralSection:Int {
        case SecretIdentityRow
        case BirthdateRow
        case SexRow
        case Count
    }
}
