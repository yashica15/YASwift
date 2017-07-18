//
//  YAAppDelegate.swift
//  YASwiftLib
//
//  Created by Yashica Agrawal on 30/03/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import Toast_Swift
import Fabric
import Crashlytics
import RealmSwift
import CocoaLumberjack
import IQKeyboardManagerSwift

enum YACustomHudStyle: Int {
    case YAShowToastMessage = 1,
    YAShowActivityIndicator,
    YAHideActivityIndicator
}

@UIApplicationMain
class YAAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    class func getDelegate() -> YAAppDelegate {
        return UIApplication.shared.delegate as! YAAppDelegate
    }

    // Avoid warning of Swift 3.1
    // Method 'initialize()' defines Objective-C class method 'initialize', which is not guaranteed to be invoked by Swift and will be disallowed in future versions
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs

        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)

        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("YASwiftLib.realm")
        Realm.Configuration.defaultConfiguration = config
        DDLogDebug("Realm.Configuration == \(config)")
        
        UISearchBar.appearance().barTintColor = colorLavender
        UISearchBar.appearance().tintColor = colorWhite
        if #available(iOS 9.0, *) {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = colorLavender
        } else {
            // Fallback on earlier versions
        }
        
        //MARK: IQKeyboardManager Enable setting
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().previousNextDisplayMode = .alwaysHide

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

    func toastView(hudType:YACustomHudStyle, strToastMessage:String) -> Void {
        DDLogDebug("hudType == \(hudType), message == \(strToastMessage)");
        switch hudType {
        case .YAShowToastMessage:
            self.window?.hideToastActivity()
            
            var style = ToastStyle()
            style.messageFont = UIFont.YASystemFont(ofSize: 16.0)
            style.messageColor = UIColor.red
            style.messageAlignment = .center
            style.backgroundColor = colorWhite
            self.window?.makeToast(strToastMessage, duration: 5.0, position: .center, style: style)
            
        case .YAShowActivityIndicator:
            self.window?.makeToastActivity(.center)
            
        case .YAHideActivityIndicator:
            self.window?.hideToastActivity()
            
        }
    }

}

