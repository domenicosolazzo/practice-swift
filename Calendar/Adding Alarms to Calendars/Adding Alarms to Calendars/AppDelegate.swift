//
//  AppDelegate.swift
//  Adding Alarms to Calendars
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
    
    // Find source in the event store
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
            
            for calendar in source.calendarsForEntityType(eventType)
                as! Set<EKCalendar>{
                    if calendar.title.caseInsensitiveCompare(title) ==
                        NSComparisonResult.OrderedSame &&
                        calendar.type.value == type.value{
                            return calendar
                    }
            }
            
            return nil
    }
}

