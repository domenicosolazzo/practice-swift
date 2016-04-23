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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(animated: Bool) {
        if(request != nil){
            self.webView.loadRequest(request!)
        }
        
    }

    
}
