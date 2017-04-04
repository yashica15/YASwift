//
//  YAAppDelegate.swift
//  YASwiftLib
//
//  Created by Yashica Agrawal on 30/03/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import Toast_Swift

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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        UISearchBar.appearance().barTintColor = colorLavender
        UISearchBar.appearance().tintColor = colorWhite
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = colorLavender

        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = colorLavender
        navigationBarAppearace.barTintColor = colorLavender

        // change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:colorGrape, NSFontAttributeName:textFontLight18!]
        
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

    func showToastView(hudType:YACustomHudStyle, message:String) -> Void {
        print("hudType == \(hudType), message == \(message)");

        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.rootViewController = UIViewController()
        alertWindow.makeKeyAndVisible()
        
        switch hudType {
        case .YAShowToastMessage:
            var style = ToastStyle()
            style.messageAlignment = .center
            style.messageFont = textFontRegular14!
            style.messageColor = colorGrape
            style.backgroundColor = colorLavender
            alertWindow.rootViewController?.view.makeToast(message, duration: 5.0, position: .center, style: style)
            
        case .YAShowActivityIndicator:
            alertWindow.rootViewController?.view.makeToastActivity(.center)
            
        case .YAHideActivityIndicator:
            alertWindow.rootViewController?.view.hideToastActivity()
            
        }
    }

}

