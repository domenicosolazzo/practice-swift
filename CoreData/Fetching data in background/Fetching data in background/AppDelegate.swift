//
//  AppDelegate.swift
//  Fetching data in background
//
//  Created by Domenico Solazzo on 17/05/15.
//  License MIT
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mutablePersons = [Person]()

    //- MARK: Helper methods
    func populateDatabase(){
        
        for counter in 0..<1000{
            let person = NSEntityDescription.insertNewObjectForEntityForName(
                NSStringFromClass(Person.classForCoder()),
                inManagedObjectContext: managedObjectContext!) as! Person
            
            person.firstName = "First name \(counter)"
            person.lastName = "Last name \(counter)"
            person.age = counter
        }
        
        var savingError: NSError?
        do {
            try managedObjectContext!.save()
            print("Managed to populate the database")
        } catch let error1 as NSError {
            savingError = error1
            if let error = savingError{
                print("Failed to populate the database. Error = \(error)")
            }
        }
        
    }
    
    func newFetchRequest() -> NSFetchRequest{
        
        let request = NSFetchRequest(entityName:
            NSStringFromClass(Person.classForCoder()))
        
        request.fetchBatchSize = 20
        request.predicate = NSPredicate(format: "(age >= 100) AND (age <= 200)")
        
        // Returns only the IDs
        request.resultType = .ManagedObjectIDResultType
        return request
        
    }
    
    func processPersons(){
        
        /* Do your work here using the mutablePersons property of our app*/
        print("Some processing .....")
        
    }
    //- MARK: Application Delegate
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        /* Set up the background context */
        let backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        
        backgroundContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        /* Issue a block on the background context */
        backgroundContext.performBlock{[weak self] in
            
            let fetchError: NSError?
            let personIds = (try! backgroundContext.executeFetchRequest(
                self!.newFetchRequest())) as! [NSManagedObjectID]
            
            if fetchError == nil{
                
                let mainContext = self!.managedObjectContext
                
                /* Now go on the main context and get the objects on that
                context using their IDs */
                dispatch_async(dispatch_get_main_queue(), {
                    for personId in personIds{
                        let person = mainContext!.objectWithID(personId) as! Person
                        self!.mutablePersons.append(person)
                    }
                    self!.processPersons()
                })
            } else {
                print("Failed to execute the fetch request")
            }
            
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.domenicosolazzo.swift.Fetching_data_in_background" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Fetching_data_in_background", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Fetching_data_in_background.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }

}

