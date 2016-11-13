//
//  DetailViewController.swift
//  Presidents
//
//  Created by Domenico on 25.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPopoverControllerDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    fileprivate var languageButton: UIBarButtonItem?
    fileprivate var languagePopoverController: UIPopoverController?
    var languageString = "" {
        didSet {
            if (languageString != oldValue) {
                configureView()
            }
            if let popoverController = languagePopoverController {
                popoverController.dismiss(animated: true)
                languagePopoverController = nil
            }
        }
    }


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                let dict = detail as! [String: String]
                let urlString = modifyUrlForLanguage(url: dict["url"]!, language: languageString)
                label.text = urlString
                
                let url = URL(string: urlString)!
                let request = URLRequest(url: url)
                webView.loadRequest(request)
                
                let name = dict["name"]!
                title = name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UIDevice.current.userInterfaceIdiom == .pad {
            languageButton = UIBarButtonItem(title: "Choose Language", style: .plain,
                target: self, action: #selector(DetailViewController.toggleLanguagePopover))
            navigationItem.rightBarButtonItem = languageButton
        }
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Function takes as arguments a URL pointing to a Wikipedia page and a two-letter language code, and then returns a URL that combines the two.
    fileprivate func modifyUrlForLanguage(url: String, language lang: String?) -> String {
        var newUrl = url
        
        if let langStr = lang {
            let range = NSMakeRange(7, 2)
            if !langStr.isEmpty && (url as NSString).substring(with: range) != langStr {
                newUrl = (url as NSString).replacingCharacters(in: range, with: langStr)
            }
        }
        
        return newUrl
    }
    
    func toggleLanguagePopover() {
        if languagePopoverController == nil {
            let languageListController = LanguageListController()
            languageListController.detailViewController = self
            languagePopoverController =
                UIPopoverController(contentViewController: languageListController)
            languagePopoverController?.present(
                from: languageButton!, permittedArrowDirections: .any, animated: true)
        } else {
            languagePopoverController?.dismiss(animated: true)
            languagePopoverController = nil
        }
    }
    
    // User taps somewhere else
    func popoverControllerDidDismissPopover(_ popoverController: UIPopoverController) {
        if popoverController == languagePopoverController {
            languagePopoverController = nil
        }
    }

}

