//
//  DependentComponentPickerViewController.swift
//  Pickers
//
//  Created by Domenico on 20.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    fileprivate let stateComponent = 0
    fileprivate let zipComponent = 1
    fileprivate var stateZips:[String : [String]]!
    fileprivate var states:[String]!
    fileprivate var zips:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let bundle = Bundle.main
        // It returns an URL
        let plistURL = bundle.url(forResource: "statedictionary", withExtension: "plist")
        
        stateZips = NSDictionary(contentsOf: plistURL!)
                        as! [String : [String]]
        let allStates = stateZips.keys
        states = allStates.sorted()
        
        let selectedState = states[0]
        zips = stateZips[selectedState]
    }

    @IBOutlet weak var dependentPicker: UIPickerView!
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buttonPressed(_ sender: UIButton) {
        let stateRow =
        dependentPicker.selectedRow(inComponent: stateComponent)
        let zipRow =
        dependentPicker.selectedRow(inComponent: zipComponent)
        
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "You selected zip code \(zip)"
        let message = "\(zip) is in \(state)"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == stateComponent{
            return states.count
        }else{
            return zips.count
        }
    }
    
    // MARK:-
    // MARK: Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedState = states[row]
        zips = stateZips[selectedState]
        dependentPicker.reloadComponent(zipComponent)
        dependentPicker.selectRow(0, inComponent: zipComponent,
            animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == stateComponent{
            return states[row]
        }else{
            return zips[row]
        }
    }
    
    /// Check how wide should be each component in the picker
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if component == zipComponent {
            return pickerWidth/3
        } else {
            return 2 * pickerWidth/3
        }
    }
    
    
    
}
