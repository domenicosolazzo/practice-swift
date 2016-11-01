//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Domenico on 16/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Foundation

class NetworkOperation{
    
    lazy var config:URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session:URLSession = URLSession(configuration: self.config)
    var queryUrl:URL
    typealias JSONDictionaryCompletion = (([String: AnyObject]?) -> Void)
    
    init(url:URL){
        self.queryUrl = url
    }
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryCompletion){
        // Create the request
        let request = URLRequest(url: self.queryUrl)
        
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            // Clousure!
            
            if let httpResponse = response as? HTTPURLResponse{
                // NSHTTPURLRespons has a status code property!
                
                switch(httpResponse.statusCode){
                case 200: // Successful request
                    // Parse the json data
                    do{
                        let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String:AnyObject]
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
        })
        
        dataTask.resume()
    
    }
}
