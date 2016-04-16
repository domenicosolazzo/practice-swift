//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Domenico on 16/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Foundation

class NetworkOperation{
    
    lazy var config:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session:NSURLSession = NSURLSession(configuration: self.config)
    var queryUrl:NSURL
    
    init(url:NSURL){
        self.queryUrl = url
    }
}
