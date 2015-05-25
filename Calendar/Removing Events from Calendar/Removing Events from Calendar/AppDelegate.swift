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
    
    //- MARK: Helper methods
    func displayAccessDenied(){
        println("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        println("Access to the event store is restricted.")
    }
    
    
    
    

    
}

