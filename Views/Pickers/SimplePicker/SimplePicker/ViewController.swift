//
//  ViewController.swift
//  SimplePicker
//
//  Created by Domenico Solazzo on 04/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // PickerView
    var uiPicker: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiPicker = UIPickerView()
        // Setting the data source
        uiPicker?.dataSource = self
        // Setting the delegate
        uiPicker?.delegate = self
        // Setting the picker in the center of the screen
        uiPicker?.center = view.center
        // Adding a subview
        self.view.addSubview(uiPicker!)
    }
    
    //- MARK: UIPickerDataSource
    // How many components you want the picker to render
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == uiPicker{
            return 1
        }
        return 0
    }
    
    // How many rows you want to render
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == uiPicker{
            return 10
        }
        return 0
    }
    
    //- MARK: UIPickerDelegate
    // Showing the text for each item
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return "\(row + 1)"
    }
    
    
    
}

