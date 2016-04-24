//
//  ArticleViewController.swift
//  Browser
//
//  Created by Domenico on 21/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    var request:NSURLRequest?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.initializeView()
        if(request != nil){
            self.webView.loadRequest(request!)
        }
        
    }
    
    func initializeView(){
        self.webView.scalesPageToFit = true
    }
    
    func initializeButtons(){
        backButton.enabled = webView.canGoBack
        forwardButton.enabled = webView.canGoForward
    }

    @IBAction func closeView(sender: AnyObject) {
        dismissViewControllerAnimated(true) { 
            print("back to the main controller")
        }
    }
    
    @IBAction func goForward(sender: UIBarButtonItem) {
        if(webView.canGoBack){
            webView.goBack()
        }
    }
    @IBAction func goBack(sender: UIBarButtonItem) {
        if(webView.canGoForward){
            webView.goForward()
        }
    }
}
