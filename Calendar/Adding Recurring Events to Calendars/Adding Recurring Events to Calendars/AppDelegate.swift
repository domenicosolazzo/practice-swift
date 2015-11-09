//
//  AppDelegate.swift
//  Adding Recurring Events to Calendars
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
    
    // Requesting Calendar access
    func requestAuthorization(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event){
            
        case .Authorized:
            createRecurringEventInStore(eventStore)
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.createRecurringEventInStore(eventStore)
                    } else {
                        self!.displayAccessDenied()
                    }
                })
        case .Restricted:
            displayAccessRestricted()
        }
        
    }
    
    // Find a source in the EventStore
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
    
    // Remove an event∂∂
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
    
    //- MARK: Helper Methods
    func displayAccessDenied(){
        print("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        print("Access to the event store is restricted.")
    }
    
    /* This method finds the calendar as well */
    func createRecurringEventInStore(store: EKEventStore){
        
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
        
        createRecurringEventInStore(store, calendar: calendar!)
        
    }
    
    func createRecurringEventInStore(store: EKEventStore, calendar: EKCalendar)
        -> Bool{
            
            let event = EKEvent(eventStore: store)
            
            /* Create an event that happens today and happens
            every month for a year from now */
            let startDate = NSDate()
            
            /* The event's end date is one hour from the moment it is created */
            let oneHour:NSTimeInterval = 1 * 60 * 60
            let endDate = startDate.dateByAddingTimeInterval(oneHour)
            
            /* Assign the required properties, especially
            the target calendar */
            event.calendar = calendar
            event.title = "My Event"
            event.startDate = startDate
            event.endDate = endDate
            
            /* The end date of the recurring rule
            is one year from now */
            let oneYear:NSTimeInterval = 365 * 24 * 60 * 60;
            let oneYearFromNow = startDate.dateByAddingTimeInterval(oneYear)
            
            /* Create an Event Kit date from this date */
            let recurringEnd = EKRecurrenceEnd.recurrenceEndWithEndDate(
                oneYearFromNow) 
            
            /* And the recurring rule. This event happens every
            month (EKRecurrenceFrequencyMonthly), once a month (interval:1)
            and the recurring rule ends a year from now (end:RecurringEnd) */
            
            let recurringRule = EKRecurrenceRule(
                recurrenceWithFrequency: EKRecurrenceFrequencyMonthly,
                interval: 1,
                end: recurringEnd)
            
            /* Set the recurring rule for the event */
            event.recurrenceRules = [recurringRule]
            
            var error:NSError?
            
            do {
                try store.saveEvent(event, span: EKSpanFutureEvents)
                print("Successfully created the recurring event.")
                return true
            } catch var error1 as NSError {
                error = error1
                if let theError = error{
                    print("Failed to create the recurring " +
                        "event with error = \(theError)")
                }
            }
            
            return false
            
    }
}

