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
        self.requestAuthorization()
        return true
    }
    
    // Find Source in the EventStore
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
            
            for calendar in source.calendarsForEntityType(eventType) {
                if calendar.title.caseInsensitiveCompare(title) ==
                    NSComparisonResult.OrderedSame &&
                    calendar.type.rawValue == type.rawValue{
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
            
            print("Event title = \(event.title)")
            print("Event start date = \(event.startDate)")
            print("Event end date = \(event.endDate)")
            
            if event.attendees.count == 0{
                print("This event has no attendees")
                continue
            }
            
            for attendee in event.attendees as! [EKParticipant]{
                print("Attendee name = \(attendee.name)")
                
                let role = attendeeRole[Int(attendee.participantRole.rawValue)]
                print("Attendee role = \(role)")
                
                let status = attendeeStatus[Int(attendee.participantStatus.rawValue)]
                print("Attendee status = \(status)")
                
                let type = attendeeStatus[Int(attendee.participantType.rawValue)]
                print("Attendee type = \(type)")
                
                print("Attendee URL = \(attendee.URL)")
                
            }
            
        }
        
    }
    
    
    func enumerateTodayEventsInStore(store: EKEventStore){
        
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
        
        enumerateTodayEventsInStore(store, calendar: calendar!)
        
    }
    
    func requestAuthorization(){
        
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityType.Event){
            
        case .Authorized:
            enumerateTodayEventsInStore(eventStore)
        case .Denied:
            displayAccessDenied()
        case .NotDetermined:
            eventStore.requestAccessToEntityType(EKEntityType.Event, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted{
                        self!.enumerateTodayEventsInStore(eventStore)
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

