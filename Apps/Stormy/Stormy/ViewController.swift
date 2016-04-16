//
//  ViewController.swift
//  Stormy
//
//  Created by Domenico on 15/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    
    private var forecastApiKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getApiKey()
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(self.forecastApiKey)")
        let forecastURL = NSURL(string: "37.8267, -122.423", relativeToURL: baseURL)
        
        // NSURLSession API
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        // NSURLRequest
        let request = NSURLRequest(URL: forecastURL!)
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            print(data)
            print("I am in the background thread")
        }
        print("I'm in the main thread")
        dataTask.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getApiKey(){
        let env = NSProcessInfo.processInfo().environment
        if let key = env["FORECAST_API_KEY"]{
            self.forecastApiKey = key
        }
        
    }


}

