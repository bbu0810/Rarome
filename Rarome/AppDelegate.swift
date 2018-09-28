//
//  AppDelegate.swift
//  Rarome
//
//  Created by AntonDream on 7/19/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import GoogleMaps
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyB579RRE-NN43Ya47oIF9CyfX7WVlehmDI")
        let permission = UserDefaults.standard
        //FingerPrint
        if(permission.bool(forKey: "bUsedFingerPrint") == true){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVcIntial = storyboard.instantiateViewController(withIdentifier: "FingerPrintViewController") as UIViewController
            let mainController = UINavigationController(rootViewController: mainVcIntial)
            window?.rootViewController = mainController
        } else {
            //ConfirmPasscode
            if (permission.string(forKey: "permission") != nil){
                let storyboard = UIStoryboard(name: "Main" , bundle: nil)
                let mainVcIntial = storyboard.instantiateViewController(withIdentifier: "ConfirmPasscode") as UIViewController
                let mainController = UINavigationController(rootViewController: mainVcIntial)
                window?.rootViewController = mainController
            }
        }

        return true
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
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
//        DropDown.startListeningToKeyboard()
//        let permission = UserDefaults.standard
//        if (permission.string(forKey: "permission") != nil){
//            let storyboard = UIStoryboard(name: "stroyboard" , bundle: nil)
//            let mainVcIntial = storyboard.instantiateViewController(withIdentifier: "gotoAdminDashboardViewController")
//            let mainController = UINavigationController(rootViewController: mainVcIntial)
//            window?.rootViewController = mainController
//        }
    }

}

