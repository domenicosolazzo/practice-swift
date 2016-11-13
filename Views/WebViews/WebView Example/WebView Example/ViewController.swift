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
            let url = URL(string: "http://www.domenicosolazzo.com")
            let request = URLRequest(url: url!)
            
            // Load the request
            theWebView.load(request)
            // Adding the delegate
            theWebView.navigationDelegate = self
            
            // Adding the web view to the main view
            view.addSubview(theWebView)
        }
    }
    
    //- MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        /* Start the network activity indicator when the web view is loading */
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        /* Stop the network activity indicator when the loading finishes */
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // We do not allow clicking on a link
        if navigationAction.navigationType == WKNavigationType.linkActivated{
            let alertController = UIAlertController(title: nil, message: "Sorry, you can click any link.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // Present the alert
            self.present(alertController, animated: true, completion:nil)
            
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        // Allow all the other actions
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}

