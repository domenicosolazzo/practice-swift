//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Pasan Premaratne on 5/13/15.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    lazy var config: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.config)
    let queryURL: URL
    
    typealias JSONDictionaryCompletion = (([String: AnyObject]?) -> Void)
    
    init(url: URL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryCompletion) {
        
        let request = URLRequest(url: queryURL)
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            // 1. Check HTTP response for successful GET request
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    // 2. Create JSON object with data
                    do {
                        let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completion(jsonDictionary)
                    } catch {
                        completion(nil)
                    }
                default:
                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
                }
            } else {
                print("Error: Not a valid HTTP response")
            }
        }) 
        
        dataTask.resume()
    }
}
