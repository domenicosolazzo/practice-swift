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
    var currentRequest:URLRequest?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initialize()
    }
    
    
    func initialize(){
        webView.scalesPageToFit = true;
        webView.delegate = self;
        
        let url = URL(string: siteUrl)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if(webView.canGoBack){
            webView.goBack()
        }
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        if(webView.canGoForward){
            webView.goForward()
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.currentRequest = request
        if(navigationType == UIWebViewNavigationType.linkClicked){
            performSegue(withIdentifier: "ArticleDetailSegue", sender: self)
            return false
        }
        
        
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ArticleDetailSegue"){
            let destination = segue.destination as! ArticleViewController
            destination.request = currentRequest
        }
    }
}
