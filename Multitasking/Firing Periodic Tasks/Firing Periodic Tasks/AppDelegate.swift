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

    var paintingTimer: NSTimer?
    var window: UIWindow?


    func paint(paramTimer: NSTimer){
        println("Painting")
    }
    
    func startPainting(){
        stopPainting()
        println("Starting painting...")
        paintingTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: "paint:",
            userInfo: nil,
            repeats: true)
    }
    
    func stopPainting(){
        if let timer = paintingTimer{
            timer.invalidate()
            paintingTimer = nil
        }
    }

    func application(application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [NSObject : AnyObject]?) -> Bool {
            return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        stopPainting()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        startPainting()
    }


}

