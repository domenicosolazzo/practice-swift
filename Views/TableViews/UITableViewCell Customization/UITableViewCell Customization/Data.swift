//
//  Data.swift
//  UITableViewCell Customization
//
//  Created by Domenico on 07/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import Foundation

class Data {
    class Entry {
        let filename : String
        let heading : String
        init(fname : String, heading : String) {
            self.heading = heading
            self.filename = fname
        }
    }
    
    let places = [
        Entry(fname: "first", heading: "Heading 1"),
        Entry(fname: "second", heading: "Heading 2"),
        Entry(fname: "third", heading: "Heading 3"),
        Entry(fname: "fourth", heading: "Heading 4")
    ]
    
}
