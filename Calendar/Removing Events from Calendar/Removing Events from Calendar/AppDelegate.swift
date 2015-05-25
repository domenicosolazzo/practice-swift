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
        return true
    }
    
    // Find the source in the event store
    func sourceInEventStore(
        eventStore: EKEventStore,
        type: EKSourceType,
        title: String) -> EKSource?{
            
            for source in eventStore.sources() as! [EKSource]{
                if source.sourceType.value == type.value &&
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
            
            for calendar in source.calendarsForEntityType(eventType) as! Set<EKCalendar>{
                if calendar.title.caseInsensitiveCompare(title) ==
                    NSComparisonResult.OrderedSame &&
                    calendar.type.value == type.value{
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
                println("The selected calendar does not allow modifications.")
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
            
            let result = inEventStore.saveEvent(event,
                span: EKSpanThisEvent,
                error: &error)
            
            if result == false{
                if let theError = error{
                    println("An error occurred \(theError)")
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
                println("The selected calendar does not allow modifications.")
                return false
            }
            
            let predicate = store.predicateForEventsWithStartDate(startDate,
                endDate: endDate,
                calendars: [calendar])
            
            /* Get all the events that match the parameters */
            let events = store.eventsMatchingPredicate(predicate)
                as! [EKEvent]
            
            if events.count > 0{
                
                /* Delete them all */
                for event in events{
                    var error:NSError?
                    
                    if store.removeEvent(event,
                        span: EKSpanThisEvent,
                        commit: false,
                        error: &error) == false{
                            if let theError = error{
                                println("Failed to remove \(event) with error = \(theError)")
                            }
                    }
                }
                
                var error:NSError?
                if store.commit(&error){
                    println("Successfully committed")
                    result = true
                } else if let theError = error{
                    println("Failed to commit the event store with error = \(theError)")
                }
                
            } else {
                println("No events matched your input.")
            }
            
            return result
            
    }
    
    //- MARK: Helper methods
    func displayAccessDenied(){
        println("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        println("Access to the event store is restricted.")
    }
    
    
    
    

    
}

