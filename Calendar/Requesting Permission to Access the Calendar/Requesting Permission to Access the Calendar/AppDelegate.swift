//
//  AppDelegate.swift
//  Requesting Permission to Access the Calendar
//
//  Created by Domenico on 24/05/15.
//  License MIT
//

import UIKit
import EventKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        askingForPermissions()
        return true
    }
    
    func askingForPermissions(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event){
            
        case .Authorized:
            extractEventEntityCalendarsOutOfStore(eventStore)
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.extractEventEntityCalendarsOutOfStore(eventStore)
                    } else {
                        self!.displayAccessDenied()
                    }
                })
        case .Restricted:
            displayAccessRestricted()
        }
        
        
    }
    
    // Extract the events from an event store
    func extractEventEntityCalendarsOutOfStore(eventStore: EKEventStore){
        // Calendar types
        let calendarTypes = [
            "Local",
            "CalDAV",
            "Exchange",
            "Subscription",
            "Birthday",
        ]
        
        // Extract the calendars by EntityType: EKEntityTypeEvent or EKEntityTypeReminder
        let calendars = eventStore.calendarsForEntityType(EKEntityType.Event)
            
        for calendar in calendars{
            
            print("Calendar title = \(calendar.title)")
            print("Calendar type = \(calendarTypes[Int(calendar.type.rawValue)])")
            
            let color = UIColor(CGColor: calendar.CGColor)
            print("Calendar color = \(color)")
            
            if calendar.allowsContentModifications{
                print("This calendar allows modifications")
            } else {
                print("This calendar does not allow modifications")
            }
            
            print("--------------------------")
            
        }
    }
    
    func displayAccessDenied(){
        print("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        print("Access to the event store is restricted.")
    }
}

