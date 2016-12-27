//
//  AppDelegate.swift
//  DealsApp
//
//  Created by Chen, David on 9/18/16.
//  Copyright © 2016 Chen, David. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import FBSDKCoreKit
import FBSDKLoginKit
import Google

import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, GIDSignInDelegate{

    var window: UIWindow?
    var locationManager = CLLocationManager()
    let SJCoor = CLLocationCoordinate2D(latitude: 37.279518, longitude: -121.867905)
    let PACoor = CLLocation(latitude: 37.468319, longitude: -122.143936)
    var SFCoor = CLLocation(latitude: 37.77493, longitude: -122.419416)
    
    let SJ = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.337034, longitude: -121.881480), radius: 3200, identifier: "SanJose")
    let PA = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.468319, longitude: -122.143936), radius: 3200, identifier: "PaloAlto")
    let SF = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.77493, longitude: -122.419416), radius: 3200, identifier: "SanFrancisco")
    
    let SJSU = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.337034, longitude: -121.881480), radius: 300, identifier: "SJSU")
    let Home = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.359432, longitude: -121.889384), radius: 1500, identifier: "Home")
    let Eastridge = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.325271, longitude: -121.813871), radius: 500, identifier: "Eastridge")
    let Work = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.375581, longitude: -121.923464), radius: 500, identifier: "Work")
    
    let myDeals: DealList = DealList()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
       NSUserDefaults.standardUserDefaults().removeObjectForKey("token")   //Comment out to maintain login persistance.//
        let obj = NSUserDefaults.standardUserDefaults().objectForKey("token")
        
        if obj == nil {
        
        let welcomeHomeController:UIViewController = WelcomeHomeController(nibName: nil, bundle: nil)
        welcomeHomeController.view.backgroundColor = UIColor.whiteColor()
        let navController:UINavigationController = UINavigationController(rootViewController: welcomeHomeController)
        
        //create window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.darkGrayColor()
        self.window?.rootViewController = navController
        self.window!.makeKeyAndVisible()
        }
        
        //Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        //Google 
        var error:NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        assert(error == nil, "Error configuring google services \(error)")
        /*if error != nil {
            print(error)
            return
        }*/
        GIDSignIn.sharedInstance().delegate = self
        
        
        // Override point for customization after application launch.
        
        // Ask for Authorization from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        locationManager.startMonitoringForRegion(SJ)
        locationManager.startMonitoringForRegion(PA)
        locationManager.startMonitoringForRegion(SF)
        locationManager.startMonitoringForRegion(SJSU)
        locationManager.startMonitoringForRegion(Home)
        locationManager.startMonitoringForRegion(Eastridge)
        locationManager.startMonitoringForRegion(Work)
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Badge, .Alert, .Sound], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
//        self.createLocalNotification()    //uncomment to enable test notifications.
        
        return true
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("Did Enter Region Called!")
        
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        let numDeals: [String: AnyObject] = myDeals.getNumDeals(locValue)!  //return is of [String: AnyObject] datatype, numDeals is declared as same datatype.
        let numDealsInt: Int? = Int(numDeals["dealcount"] as! String)
        let numDealsString: String? = numDeals["dealcount"] as! String   //Fix for iOS9+ on rendering number of deals.
        
        let localNotification = UILocalNotification()
//        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        localNotification.region = region
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.regionTriggersOnce = false
//
        if(numDealsInt != 0) {
            if(region.identifier == "SanJose") {
                localNotification.alertBody = "You Have \(numDealsString) New Deals in San Jose!"
            }
            else if(region.identifier == "PaloAlto") {
                localNotification.alertBody = "You Have \(numDealsString) New Deals in Palo Alto!"
            }
            else if(region.identifier == "SanFrancisco") {
                localNotification.alertBody = "You Have \(numDealsString) New Deals in San Francisco!"
            }
            else if(region.identifier == "SJSU") {
                localNotification.alertBody = "You Have \(numDealsString) New Deals in SJSU!"
            }
            else if(region.identifier == "Home") {
                localNotification.alertBody = "You Have \(numDealsString) New Deals in \(region.identifier)!"
            }
            else if(region.identifier == "Eastridge") {
                localNotification.alertBody = "You Have \(numDealsString) New Deals in Eastridge!"
            }
            else if(region.identifier == "Work") {
                localNotification.alertBody = "You Have \(numDealsString) New Deals in Work!"
            }
            else {
                print ("No Region Identified")
            }
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
//        localNotification.alertBody = "Watch Notification Test"
        
    }
    
//    func createLocalNotification() {
//        let localNotification = UILocalNotification()
//        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
//        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
//        localNotification.soundName = UILocalNotificationDefaultSoundName
//        localNotification.alertBody = "Watch Notification Test"
//        
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//    }
//
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        let currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
//
//        let numDeals: [String: AnyObject] = myDeals.getNumDeals(locValue)!
//        let numDealsInt: Int? = Int(numDeals["dealcount"] as! String)
//        
//        if(numDealsInt != 0) {
//            print("numDeals: \(numDeals["dealcount"]!)")    //Unwraps optionals.
//        }
//
//        if(SFCoor.distanceFromLocation(currentLocation) <= 10000) {
//            createLocalNotification(locValue, city: "San Francisco")
//        }
//        else if(PACoor.distanceFromLocation(currentLocation) <= 10000) {
//            createLocalNotification(locValue, city: "Palo Alto")
//        }
//        else {
//            createLocalNotification(SJCoor, city: "San Jose")
//        }
//        print("App Delegate locations = \(locValue.latitude) \(locValue.longitude)")
//    }
    
//    func createLocalNotification(currentLoc: CLLocationCoordinate2D, city: String) {
//        
//        let localNotification = UILocalNotification()
//        localNotification.region = CLCircularRegion(center: currentLoc, radius: 10000, identifier: "Deals")
//        localNotification.applicationIconBadgeNumber = count + 1
//        localNotification.soundName = UILocalNotificationDefaultSoundName
//        localNotification.alertBody = "You Have a New Deal in \(city)!"
//        localNotification.regionTriggersOnce = false
//        
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//    }

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
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) || GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "CMPE295B.DealsApp" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("DealsApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        print(user.profile.email)
        let userID = user.userID
        let viewController = WelcomeHomeController()
        dispatch_main()
        viewController.connectToserver(userID)
        
    }
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        print("Logged out")
    }

}

