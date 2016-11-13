//
//  AppDelegate.swift
//  Firing Periodic Tasks
//
//  Created by Domenico Solazzo on 13/05/15.
//  License MIT
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var paintingTimer: Timer?
    var window: UIWindow?


    func paint(_ paramTimer: Timer){
        print("Painting")
    }
    
    func startPainting(){
        stopPainting()
        print("Starting painting...")
        paintingTimer = Timer.scheduledTimer(timeInterval: 1.0,
            target: self,
            selector: #selector(AppDelegate.paint(_:)),
            userInfo: nil,
            repeats: true)
    }
    
    func stopPainting(){
        if let timer = paintingTimer{
            timer.invalidate()
            paintingTimer = nil
        }
    }

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        stopPainting()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        startPainting()
    }


}

