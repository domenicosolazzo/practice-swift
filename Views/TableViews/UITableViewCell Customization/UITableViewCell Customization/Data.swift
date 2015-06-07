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
        Entry(fname: "first.jpeg", heading: "Heading 1"),
        Entry(fname: "second.jpeg", heading: "Heading 2"),
        Entry(fname: "third.jpeg", heading: "Heading 3"),
        Entry(fname: "fourth.jpeg", heading: "Heading 4")
    ]
    
}
