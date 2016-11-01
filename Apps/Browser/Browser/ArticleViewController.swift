//
//  ArticleViewController.swift
//  Browser
//
//  Created by Domenico on 21/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    var request:URLRequest?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initializeView()
        if(request != nil){
            self.webView.loadRequest(request!)
        }
        
    }
    
    func initializeView(){
        self.webView.scalesPageToFit = true
    }
    
    func initializeButtons(){
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }

    @IBAction func closeView(_ sender: AnyObject) {
        dismiss(animated: true) { 
            print("back to the main controller")
        }
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        if(webView.canGoBack){
            webView.goBack()
        }
    }
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if(webView.canGoForward){
            webView.goForward()
        }
    }
}
