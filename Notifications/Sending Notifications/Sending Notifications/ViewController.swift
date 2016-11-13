//
//  ViewController.swift
//  Sending Notifications
//
//  Created by Domenico Solazzo on 15/05/15.
//  License MIT
//

import UIKit

class ViewController: UIViewController {
    let notificationName = "MyNotificationName"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Creating the notification
        let notification = Notification(
            name: Notification.Name(rawValue: notificationName),
            object: self,
            userInfo: [
                "Key1": "Value1",
                "Key2": "Value2"
            ])
        // Sending the notification
        NotificationCenter.default.post(notification)
    }
}

