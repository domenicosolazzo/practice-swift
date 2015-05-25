//
//  AppDelegate.swift
//  Retrieving the Attendees of an Event
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
    
    // Find Source in the EventStore
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
    
    // Find calendar by Title
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
    
    func enumerateTodayEventsInStore(store: EKEventStore, calendar: EKCalendar){
        
        /* The event starts from today, right now */
        let startDate = NSDate()
        
        /* The end date will be 1 day from now */
        let endDate = startDate.dateByAddingTimeInterval(24 * 60 * 60)
        
        /* Create the predicate that we can later pass to
        the event store in order to fetch the events */
        let searchPredicate = store.predicateForEventsWithStartDate(
            startDate,
            endDate: endDate,
            calendars: [calendar])
        
        /* Fetch all the events that fall between the
        starting and the ending dates */
        let events = store.eventsMatchingPredicate(searchPredicate)
            as! [EKEvent]
        
        /* Array of NSString equivalents of the values
        in the EKParticipantRole enumeration */
        let attendeeRole = [
            "Unknown",
            "Required",
            "Optional",
            "Chair",
            "Non Participant",
        ]
        
        /* Array of NSString equivalents of the values
        in the EKParticipantStatus enumeration */
        let attendeeStatus = [
            "Unknown",
            "Pending",
            "Accepted",
            "Declined",
            "Tentative",
            "Delegated",
            "Completed",
            "In Process",
        ]
        
        /* Array of NSString equivalents of the values
        in the EKParticipantType enumeration */
        let attendeeType = [
            "Unknown",
            "Person",
            "Room",
            "Resource",
            "Group"
        ]
        
        /* Go through all the events and print their information
        out to the console */
        
        for event in events{
            
            println("Event title = \(event.title)")
            println("Event start date = \(event.startDate)")
            println("Event end date = \(event.endDate)")
            
            if event.attendees.count == 0{
                println("This event has no attendees")
                continue
            }
            
            for attendee in event.attendees as! [EKParticipant]{
                println("Attendee name = \(attendee.name)")
                
                let role = attendeeRole[Int(attendee.participantRole.value)]
                println("Attendee role = \(role)")
                
                let status = attendeeStatus[Int(attendee.participantStatus.value)]
                println("Attendee status = \(status)")
                
                let type = attendeeStatus[Int(attendee.participantType.value)]
                println("Attendee type = \(type)")
                
                println("Attendee URL = \(attendee.URL)")
                
            }
            
        }
        
    }
    
    //- MARK: Helper methods
    func displayAccessDenied(){
        println("Access to the event store is denied.")
    }
    
    func displayAccessRestricted(){
        println("Access to the event store is restricted.")
    }


}

