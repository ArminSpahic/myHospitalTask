//
//  AppDelegate.swift
//  Task
//
//  Created by Armin Spahic on 15/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore
import Firebase
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        // Override point for customization after application launch.
        FirebaseApp.configure()
        TWTRTwitter.sharedInstance().start(withConsumerKey: Globals().TWITTER_CONSUMER_KEY, consumerSecret: Globals().TWITTER_CONSUMER_SECRET)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if UserDefaults.standard.bool(forKey: Globals().LOGGED_IN) == true {
            let navigationController = storyboard.instantiateViewController(withIdentifier: "navigationController")
            self.window?.rootViewController = navigationController
        } else {
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
            self.window?.rootViewController = initialViewController
        }
       // FirebaseApp.configure()
     
        return true
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let twitterLogin = TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        let facebookLogin = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        return twitterLogin || facebookLogin
        
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

