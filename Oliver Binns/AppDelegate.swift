//
//  AppDelegate.swift
//  Oliver Binns
//
//  Created by Oliver on 26/04/2015.
//  Copyright (c) 2015 Oliver Binns. All rights reserved.
//

import UIKit
import WatchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //We've just launched!
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasJustLaunched");
        NSUserDefaults.standardUserDefaults().synchronize();
        // Override point for customization after application launch.
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
    }
    
    //Called when the WatchKit app is launched and requests a story!
    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        //Replies to Apple Watch request with some new data!
        reply(getRandomData() as [NSObject : AnyObject]);
    }
    
    func getRandomData() -> NSDictionary{
        //Randomly generates a number to determine which category to use
        var x = arc4random() % 4;
        var array = ["Music", "Work", "School", "Code"];
        //Generates a model controller for this category for easy access of the data
        var test: ModelController = ModelController(dataSet: array[Int(x)]);
        //Randomly generates another number to determine which story
        x = arc4random() % UInt32(test.pageData.count);
        var dictionary = NSMutableDictionary();
        var data = test.pageData[Int(x)] as!DataObject;
        //Returns a story as a dictionary in the form of a title and description!
        dictionary.setObject(data.name!, forKey: "title");
        dictionary.setObject(data.text!, forKey: "description");
        println(dictionary);
        return dictionary;
    }
    


}

