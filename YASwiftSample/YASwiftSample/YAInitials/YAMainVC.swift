//
//  YAMainVC.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import SideMenu

class YAMainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main View"
        
        // Side Menu Bar Presentation settings
        // For more detail visit reference: https://github.com/jonkykong/SideMenu
        setupSideMenu()
//        updateUI(settings: SideMenuSettings())

    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
//        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "YALeftMenuTVC") as? SideMenuNavigationController
        SideMenuManager.default.rightMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "YARightMenuTVC") as? SideMenuNavigationController

        let leftMenuViewController = storyboard?.instantiateViewController(withIdentifier: "YALeftMenuTVC") as? SideMenuNavigationController
        var sideMenuSet = SideMenuSettings()

        SideMenuManager.default.leftMenuNavigationController =
            SideMenuNavigationController(rootViewController: leftMenuViewController ?? UIViewController() ,settings: sideMenuSet)

        sideMenuSet.presentationStyle.backgroundColor = UIColor.clear
        sideMenuSet.presentationStyle = .menuSlideIn
        sideMenuSet.menuWidth = UIScreen.main.bounds.width * 0.8

        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)

        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0

//        SideMenuManager.menuPresentMode = .menuSlideIn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

