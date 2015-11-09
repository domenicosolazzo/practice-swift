//
//  AppDelegate.swift
//  Adding Events to Calendars
//
//  Created by Domenico on 25/05/15.
//  License MIT
//

import UIKit
import EventKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        self.requestCalendarAuthorization()
        return true
    }
    // Find the source in the eventStore
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
    
    // Find a calendar by title
    func calendarWithTitle(
        title: String,
        type: EKCalendarType,
        source: EKSource,
        eventType: EKEntityType) -> EKCalendar?{
            
            for calendar in source.calendarsForEntityType(eventType) {
                if calendar.title.caseInsensitiveCompare(title) ==
                    NSComparisonResult.OrderedSame &&
                    calendar.type.rawValue == type.rawValue{
                        return calendar
                }
            }
            
            return nil
    }
    
    // Create a new event
    func createEventWithTitle(
        title: String,
        startDate: NSDate,
        endDate: NSDate,
        inCalendar: EKCalendar,
        inEventStore: EKEventStore,
        notes: String) -> Bool{
            
            /* If a calendar does not allow modification of its contents
            then we cannot insert an event into it */
            if inCalendar.allowsContentModifications == false{
                print("The selected calendar does not allow modifications.")
                return false
            }
            
            /* Create an event */
            var event = EKEvent(eventStore: inEventStore)
            event.calendar = inCalendar
            
            /* Set the properties of the event such as its title,
            start date/time, end date/time, etc. */
            event.title = title
            event.notes = notes
            event.startDate = startDate
            event.endDate = endDate
            
            /* Finally, save the event into the calendar */
            var error:NSError?
            
            let result: Bool
            do {
                try inEventStore.saveEvent(event,
                                span: EKSpanThisEvent)
                result = true
            } catch var error1 as NSError {
                error = error1
                result = false
            }
            
            if result == false{
                if let theError = error{
                    print("An error occurred \(theError)")
                }
            }
            
            return result
    }
    
    // Insert event in the event store
    func insertEventIntoStore(store: EKEventStore){
        
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
        
        /* The event starts from today, right now */
        let startDate = NSDate()
        
        /* And the event ends this time tomorrow.
        24 hours, 60 minutes per hour and 60 seconds per minute
        hence 24 * 60 * 60 */
        let endDate = startDate.dateByAddingTimeInterval(24 * 60 * 60)
        
        if createEventWithTitle("My Concert",
            startDate: startDate,
            endDate: endDate,
            inCalendar: calendar!,
            inEventStore: store,
            notes: ""){
                print("Successfully created the event.")
        } else {
            print("Failed to create the event.")
        }
        
    }
    
    // Request Calendar authorization
    func requestCalendarAuthorization(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event){
            
        case .Authorized:
            insertEventIntoStore(eventStore)
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.insertEventIntoStore(eventStore)
                    } else {
                        self!.displayAccessDenied()
                    }
                })
        case .Restricted:
            displayAccessRestricted()
        }
        
        
    }
    
    func displayAccessDenied(){
        print("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        print("Access to the event store is restricted.")
    }
    
}

