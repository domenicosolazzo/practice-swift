//
//  AppDelegate.swift
//  Retrieving Calendar Groups
//
//  Created by Domenico on 24/05/15.
//  License MIT
//

import UIKit
import EventKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        requestCalendarAuthorization()
        return true
    }
    
    func requestCalendarAuthorization(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent){
            
        case .Authorized:
            findIcloudEventSource()
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.findIcloudEventSource()
                    } else {
                        self!.displayAccessDenied()
                    }
                })
        case .Restricted:
            displayAccessRestricted()
        }
        
        
    }
    
    func findIcloudEventSource(){
        var icloudEventSource: EKSource?
        
        let eventStore = EKEventStore()
        for source in eventStore.sources() as! [EKSource]{
            if source.sourceType.value == EKSourceTypeCalDAV.value &&
                source.title.lowercaseString == "icloud"{
                    icloudEventSource = source
            }
        }
        
        if let source = icloudEventSource{
            println("The iCloud event source was found = \(source)")
            
            let calendars = source.calendarsForEntityType(EKEntityTypeEvent)
            
            for calendar in calendars as! Set<EKCalendar>{
                println(calendar)
            }
            
        } else {
            println("Could not find the iCloud event source")
        }
        
    }
  
    
    //- MARK: Helper methods
    func displayAccessDenied(){
        println("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        println("Access to the event store is restricted.")
    }
}

