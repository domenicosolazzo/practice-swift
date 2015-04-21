//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by Domenico on 20.04.15.
//  Copyright (c) 2015 Domenico Solazzo. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private var images:[UIImage]!
    private var winSoundID: SystemSoundID = 0
    private var crunchSoundID: SystemSoundID = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "crown")!,
            UIImage(named: "cherry")!,
            UIImage(named: "lemon")!,
            UIImage(named: "apple")!
        ]
        winLabel.text = " " // Note the space between the quotes
    }

    func showButton() {
        button.hidden = false
    }
    
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    @IBOutlet weak var picker: UIPickerView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func spin(sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        
        for i in 0..<5 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastVal {
                numInRow++
            } else {
                numInRow = 1
            }
            lastVal = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
            if numInRow >= 3 {
                win = true
            }
        }
        
        winLabel.text = win ? "WINNER!" : " "
    }
    
    // MARK:-
    // MARK: Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            return images.count
    }
    
    // MARK:-
    // MARK: Picker Delegate Methods
    // We can supply the picker with anything that can be draw in this picker
    func pickerView(pickerView: UIPickerView, viewForRow row: Int,
        forComponent component: Int,
        reusingView view: UIView!) -> UIView {
            let image = images[row]
            let imageView = UIImageView(image: image)
            return imageView
    }
    
    func pickerView(pickerView: UIPickerView,
        rowHeightForComponent component: Int) -> CGFloat {
            return 64
    }
    
}
