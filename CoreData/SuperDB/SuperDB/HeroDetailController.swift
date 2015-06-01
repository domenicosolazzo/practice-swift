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
    var sections: [AnyObject]!
    var hero: NSManagedObject!
    
    override func viewDidLoad() {
        var plistURL = NSBundle.mainBundle().URLForResource("HeroDetailConfiguration", withExtension: "plist")
        var plist = NSDictionary(contentsOfURL: plistURL!)
        self.sections = plist?.valueForKey("sections") as! NSArray as [AnyObject]
    }
}
