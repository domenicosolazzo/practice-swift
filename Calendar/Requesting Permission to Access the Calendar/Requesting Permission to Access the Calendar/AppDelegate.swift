//
//  AppDelegate.swift
//  Requesting Permission to Access the Calendar
//
//  Created by Domenico on 24/05/15.
//  License MIT
//

import UIKit
import EventKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Extract the events from an event store
    func extractEventEntityCalendarsOutOfStore(eventStore: EKEventStore){
        // Calendar types
        let calendarTypes = [
            "Local",
            "CalDAV",
            "Exchange",
            "Subscription",
            "Birthday",
        ]
        
        // Extract the calendars by EntityType: EKEntityTypeEvent or EKEntityTypeReminder
        let calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent)
            as! [EKCalendar]
        for calendar in calendars{
            
            println("Calendar title = \(calendar.title)")
            println("Calendar type = \(calendarTypes[Int(calendar.type.value)])")
            
            let color = UIColor(CGColor: calendar.CGColor)
            println("Calendar color = \(color)")
            
            if calendar.allowsContentModifications{
                println("This calendar allows modifications")
            } else {
                println("This calendar does not allow modifications")
            }
            
            println("--------------------------")
            
        }
    }
}

