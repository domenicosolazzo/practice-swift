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
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        // Adding configuration
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        
        if let theWebView = webView{
            let url = NSURL(string: "http://www.domenicosolazzo.com")
            let request = NSURLRequest(URL: url!)
            
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
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        // We do not allow clicking on a link
        if navigationAction.navigationType == WKNavigationType.LinkActivated{
            let alertController = UIAlertController(title: nil, message: "Sorry, you can click any link.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            // Present the alert
            self.presentViewController(alertController, animated: true, completion:nil)
            
            decisionHandler(WKNavigationActionPolicy.Cancel)
            return
        }
        // Allow all the other actions
        decisionHandler(WKNavigationActionPolicy.Allow)
    }
}

