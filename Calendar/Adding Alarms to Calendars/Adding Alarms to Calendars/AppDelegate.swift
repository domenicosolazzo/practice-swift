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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.requestAuthorization()
        return true
    }
    
    // Request calendar authorization
    func requestAuthorization(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: EKEntityType.event){
            
        case .authorized:
            addAlarmToCalendarWithStore(eventStore)
        case .denied:
            displayAccessDenied()
        case .notDetermined:
            eventStore.requestAccess(to: EKEntityType.event, completion:
                {[weak self] (granted: Bool, error: NSError?) -> Void in
                    if granted{
                        self!.addAlarmToCalendarWithStore(eventStore)
                    } else {
                        self!.displayAccessDenied()
                    }
                } as! EKEventStoreRequestAccessCompletionHandler)
        case .restricted:
            displayAccessRestricted()
        }
        
    }
    
    // Find source in the event store
    func sourceInEventStore(
        _ eventStore: EKEventStore,
        type: EKSourceType,
        title: String) -> EKSource?{
            
            for source in eventStore.sources {
                if source.sourceType.rawValue == type.rawValue &&
                    source.title.caseInsensitiveCompare(title) ==
                    ComparisonResult.orderedSame{
                        return source
                }
            }
            
            return nil
    }
    
    // Find calendar by Title
    func calendarWithTitle(
        _ title: String,
        type: EKCalendarType,
        source: EKSource,
        eventType: EKEntityType) -> EKCalendar?{
            
            for calendar in source.calendars(for: eventType)
                {
                    if calendar.title.caseInsensitiveCompare(title) ==
                        ComparisonResult.orderedSame &&
                        calendar.type.rawValue == type.rawValue{
                            return calendar
                    }
            }
            
            return nil
    }
    
    func addAlarmToCalendarWithStore(_ store: EKEventStore, calendar: EKCalendar){
        
        /* The event starts 60 seconds from now */
        let startDate = Date(timeIntervalSinceNow: 60.0)
        
        /* And end the event 20 seconds after its start date */
        let endDate = startDate.addingTimeInterval(20.0)
        
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
    
    func addAlarmToCalendarWithStore(_ store: EKEventStore){
        
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

