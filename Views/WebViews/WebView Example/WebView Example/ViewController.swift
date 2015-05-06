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
        
        
        
    }
}

