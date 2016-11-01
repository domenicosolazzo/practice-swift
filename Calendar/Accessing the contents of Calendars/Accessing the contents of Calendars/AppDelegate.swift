//
//  AppDelegate.swift
//  Accessing the contents of Calendars
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
    
    // Find the source in the event store
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
    
    // Finding a calendar by Title
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
    
    func displayAccessDenied(){
        print("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        print("Access to the event store is restricted.")
    }
    
    func readEvents(){
        
        /* Instantiate the event store */
        let eventStore = EKEventStore()
        
        let icloudSource = sourceInEventStore(eventStore,
            type: EKSourceType(rawValue: kABSourceTypeCardDAV)!,
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
        
        /* The event starts from today, right now */
        let startDate = Date()
        
        /* The end date will be 1 day from today */
        let endDate = startDate.addingTimeInterval(24 * 60 * 60)
        
        /* Create the predicate that we can later pass to the
        event store in order to fetch the events */
        let searchPredicate = eventStore.predicateForEventsWithStartDate(
            startDate,
            endDate: endDate,
            calendars: [calendar!])
        
        /* Fetch all the events that fall between
        the starting and the ending dates */
        let events = eventStore.eventsMatchingPredicate(searchPredicate)
            as! [EKEvent]
        
        if events.count == 0{
            print("No events could be found")
        } else {
            
            /* Go through all the events and print their information
            out to the console */
            for event in events{
                print("Event title = \(event.title)")
                print("Event start date = \(event.startDate)")
                print("Event end date = \(event.endDate)")
            }
        }
        
    }
    
    // Request access to the calendar
    func requestAuthorization(){
        
        switch EKEventStore.authorizationStatus(for: EKEntityType.event){
            
        case .authorized:
            readEvents()
        case .denied:
            displayAccessDenied()
        case .notDetermined:
            EKEventStore().requestAccess(to: EKEntityType.event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.readEvents()
                    } else {
                        self!.displayAccessDenied()
                    }
                } as! EKEventStoreRequestAccessCompletionHandler)
        case .restricted:
            displayAccessRestricted()
        }
        
    }
    

}

