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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.requestAuthorization()
        return true
    }
    
    // Find the source in the event store
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
    
    // Finding a calendar by Title
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
        
        /* The event starts from today, right now */
        let startDate = NSDate()
        
        /* The end date will be 1 day from today */
        let endDate = startDate.dateByAddingTimeInterval(24 * 60 * 60)
        
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
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event){
            
        case .Authorized:
            readEvents()
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            EKEventStore().requestAccessToEntityType(EKEntityType.Event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.readEvents()
                    } else {
                        self!.displayAccessDenied()
                    }
                })
        case .Restricted:
            displayAccessRestricted()
        }
        
    }
    

}

