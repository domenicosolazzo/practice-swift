//
//  AppDelegate.swift
//  Removing Events from Calendar
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
    
    // Find a calendar by Title
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
    
    func removeEventWithTitle(
        title: String,
        startDate: NSDate,
        endDate: NSDate,
        store: EKEventStore,
        calendar: EKCalendar,
        notes: String) -> Bool{
            
            var result = false
            
            /* If a calendar does not allow modification of its contents
            then we cannot insert an event into it */
            if calendar.allowsContentModifications == false{
                print("The selected calendar does not allow modifications.")
                return false
            }
            
            let predicate = store.predicateForEventsWithStartDate(startDate,
                endDate: endDate,
                calendars: [calendar])
            
            /* Get all the events that match the parameters */
            let events = store.eventsMatchingPredicate(predicate)
                
            
            if events.count > 0{
                
                /* Delete them all */
                for event in events{
                    var error:NSError?
                    
                    if store.removeEvent(event,
                        span: EKSpanThisEvent,
                        commit: false) == false{
                            if let theError = error{
                                print("Failed to remove \(event) with error = \(theError)")
                            }
                    }
                }
                
                var error:NSError?
                do {
                    try store.commit()
                    print("Successfully committed")
                    result = true
                } catch var error1 as NSError {
                    error = error1
                    if let theError = error{
                        print("Failed to commit the event store with error = \(theError)")
                    }
                }
                
            } else {
                print("No events matched your input.")
            }
            
            return result
            
    }
    
    func createAndDeleteEventInStore(store: EKEventStore){
        
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
        
        /* The end date will be 1 day from today */
        let endDate = startDate.dateByAddingTimeInterval(24 * 60 * 60)
        
        let eventTitle = "My Event"
        
        if createEventWithTitle(eventTitle,
            startDate: startDate,
            endDate: endDate,
            inCalendar: calendar!,
            inEventStore: store,
            notes: ""){
                print("Successfully created the event")
        } else {
            print("Could not create the event")
            return
        }
        
        if removeEventWithTitle(eventTitle,
            startDate: startDate,
            endDate: endDate,
            store: store,
            calendar: calendar!,
            notes: ""){
                print("Successfully created and deleted the event")
        } else {
            print("Failed to delete the event")
        }
    }
    
    func requestAuthorization(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event){
            
        case .Authorized:
            createAndDeleteEventInStore(eventStore)
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.createAndDeleteEventInStore(eventStore)
                    } else {
                        self!.displayAccessDenied()
                    }
                })
        case .Restricted:
            displayAccessRestricted()
        }
        
    }
    
    //- MARK: Helper methods
    func displayAccessDenied(){
        print("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        print("Access to the event store is restricted.")
    }
    
    
    
    

    
}

