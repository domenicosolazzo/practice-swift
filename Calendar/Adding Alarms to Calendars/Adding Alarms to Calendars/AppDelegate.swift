//
//  AppDelegate.swift
//  Adding Alarms to Calendars
//
//  Created by Domenico on 25/05/15.
//  License MIT
//

import UIKit
import EventKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.requestAuthorization()
        return true
    }
    
    // Request calendar authorization
    func requestAuthorization(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event){
            
        case .Authorized:
            addAlarmToCalendarWithStore(eventStore)
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.addAlarmToCalendarWithStore(eventStore)
                    } else {
                        self!.displayAccessDenied()
                    }
                })
        case .Restricted:
            displayAccessRestricted()
        }
        
    }
    
    // Find source in the event store
    func sourceInEventStore(
        eventStore: EKEventStore,
        type: EKSourceType,
        title: String) -> EKSource?{
            
            for source in eventStore.sources as! [EKSource]{
                if source.sourceType.rawValue == type.rawValue &&
                    source.title.caseInsensitiveCompare(title) ==
                    NSComparisonResult.OrderedSame{
                        return source
                }
            }
            
            return nil
    }
    
    // Find calendar by Title
    func calendarWithTitle(
        title: String,
        type: EKCalendarType,
        source: EKSource,
        eventType: EKEntityType) -> EKCalendar?{
            
            for calendar in source.calendarsForEntityType(eventType)
                {
                    if calendar.title.caseInsensitiveCompare(title) ==
                        NSComparisonResult.OrderedSame &&
                        calendar.type.rawValue == type.rawValue{
                            return calendar
                    }
            }
            
            return nil
    }
    
    func addAlarmToCalendarWithStore(store: EKEventStore, calendar: EKCalendar){
        
        /* The event starts 60 seconds from now */
        let startDate = NSDate(timeIntervalSinceNow: 60.0)
        
        /* And end the event 20 seconds after its start date */
        let endDate = startDate.dateByAddingTimeInterval(20.0)
        
        let eventWithAlarm = EKEvent(eventStore: store)
        eventWithAlarm.calendar = calendar
        eventWithAlarm.startDate = startDate
        eventWithAlarm.endDate = endDate
        
        /* The alarm goes off 2 seconds before the event happens */
        let alarm = EKAlarm(relativeOffset: -2.0)
        
        eventWithAlarm.title = "Event with Alarm"
        eventWithAlarm.addAlarm(alarm)
        
        var error:NSError?
        do {
            try store.saveEvent(eventWithAlarm, span: EKSpanThisEvent)
            print("Saved an event that fires 60 seconds from now.")
        } catch var error1 as NSError {
            error = error1
            if let theError = error{
                print("Failed to save the event. Error = \(theError)")
            }
        }
        
    }
    
    func addAlarmToCalendarWithStore(store: EKEventStore){
        
        let icloudSource = sourceInEventStore(store,
            type: EKSourceTypeCalDAV,
            title: "iCloud")
        
        if icloudSource == nil{
            print("You have not configured iCloud for your device.")
            return
        }
        
        let calendar = calendarWithTitle("Calendar",
            type: EKCalendarTypeCalDAV,
            source: icloudSource!,
            eventType: EKEntityType.Event)
        
        if calendar == nil{
            print("Could not find the calendar we were looking for.")
            return
        }
        
        addAlarmToCalendarWithStore(store, calendar: calendar!)
        
    }
    
    //- MARK: Helper methods
    func displayAccessDenied(){
        print("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        print("Access to the event store is restricted.")
    }
}

