//
//  ViewController.swift
//  Styled Button in the NavigationBar
//
//  Created by Domenico Solazzo on 06/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    func performAdd(_ sender: UIBarButtonItem){
        print("AAAS => Add As A Service :)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.add,
            target: self,
            action: #selector(ViewController.performAdd(_:)))
    }
}

