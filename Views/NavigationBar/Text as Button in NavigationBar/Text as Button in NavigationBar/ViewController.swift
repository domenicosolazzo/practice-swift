//
//  ViewController.swift
//  Text as Button in NavigationBar
//
//  Created by Domenico Solazzo on 05/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {

    func performAdd(_ sender: UIBarButtonItem){
        print("Add method got called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(ViewController.performAdd(_:)))
        
    }

    
}

