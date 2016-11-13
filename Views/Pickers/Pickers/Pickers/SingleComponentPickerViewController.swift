//
//  SingleComponentPickerViewController.swift
//  Pickers
//
//  Created by Domenico on 20.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class SingleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var picker: UIPickerView!
    // Data
    fileprivate let characterNames = [
        "Luke", "Leia", "Han", "Chewbacca", "Artoo",
        "Threepio", "Lando"]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        // Selected row in the picker view
        let row = picker.selectedRow(inComponent: 0)
        // Select the string in the array
        let selected = characterNames[row]
        
        let title = "You selected \(selected)!"
        
        let alert = UIAlertController(
            title: title,
            message: "Thank you for choosing",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "You are welcome", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    // MARK: -
    // MARK: - Picker Data Source Methods
    /*
        Picker can have more than one component in the spinning wheel
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // How many row the picker view contains
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characterNames.count
    }
    
    // MARK: - Picker Delegate Methods
    // Provide the data for a specific row in a specific component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return characterNames[row]
    }
}
