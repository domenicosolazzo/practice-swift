//
//  BrowserViewController.swift
//  Browser
//
//  Created by Domenico on 21/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    var siteUrl: String = "https://www.google.com"
    var currentRequest:NSURLRequest?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.initialize()
    }
    
    
    func initialize(){
        webView.scalesPageToFit = true;
        webView.delegate = self;
        
        let url = NSURL(string: siteUrl)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        if(webView.canGoBack){
            webView.goBack()
        }
    }
    
    @IBAction func goForward(sender: UIBarButtonItem) {
        if(webView.canGoForward){
            webView.goForward()
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.currentRequest = request
        if(navigationType == UIWebViewNavigationType.LinkClicked){
            performSegueWithIdentifier("ArticleDetailSegue", sender: self)
            return false
        }
        
        
        return true
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ArticleDetailSegue"){
            let destination = segue.destinationViewController as! ArticleViewController
            destination.request = currentRequest
        }
    }
}
