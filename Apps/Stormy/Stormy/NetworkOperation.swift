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
    typealias JSONDictionaryCompletion = ([String: AnyObject]? -> Void)
    
    init(url:NSURL){
        self.queryUrl = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion){
        // Create the request
        let request = NSURLRequest(URL: self.queryUrl)
        
        let dataTask = session.dataTaskWithRequest(request){
            (let data, let response, let error) in
            // Clousure!
            
            if let httpResponse = response as? NSHTTPURLResponse{
                // NSHTTPURLRespons has a status code property!
                
                switch(httpResponse.statusCode){
                case 200: // Successful request
                    // Parse the json data
                    do{
                        let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String:AnyObject]
                        // Call the callback function "completion"
                        completion(jsonDictionary!)
                    }catch(_){
                        print("Error parsing the data!!")
                    }
                    
                    
                default:
                    print("Error requesting the data. Status Code \(httpResponse.statusCode)")
                }
            }else{
                print("Error requesting the data. The response is invalid")
            }
        }
        
        dataTask.resume()
    
    }
}
