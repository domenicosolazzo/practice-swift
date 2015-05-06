//
//  ViewController.swift
//  WebView Example
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding preferences
        var preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        // Adding configuration
        var configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        
        if let theWebView = webView{
            var url = NSURL(string: "http://www.domenicosolazzo.com")
            var request = NSURLRequest(URL: url!)
            
            // Load the request
            theWebView.loadRequest(request)
            // Adding the delegate
            theWebView.navigationDelegate = self
            
            // Adding the web view to the main view
            view.addSubview(theWebView)
        }
    }
    
    //- MARK: WKNavigationDelegate
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        /* Start the network activity indicator when the web view is loading */
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        /* Stop the network activity indicator when the loading finishes */
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

